//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 21.03.2024.
//

import Foundation
import CoreLocation
import MapKit

final class MainViewPresenter: NSObject, MainViewPresenterProtocol {
    private let mainView: MainViewProtocol
    private let weatherService: WeatherServiceProtocol
    
    private let locationManager: CLLocationManager
    private var currentCoordinates: CLLocation?
    
    var listWeatherForDays: [WeatherForDays]?
    
    init(view: MainViewProtocol, weatherService: WeatherServiceProtocol) {
        self.mainView = view
        self.weatherService = weatherService
        
        self.locationManager = CLLocationManager()
        self.listWeatherForDays = []
    }
    
    func seacrhWeather(_ text: String) {
        listWeatherForDays?.removeAll()
        mainViewClearShowingData()
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        let search = MKLocalSearch(request: searchRequest)
        
        DispatchQueue.global().async {
            search.start { [weak self] response, error in
                guard let response = response else {
                    self?.mainViewShowError(error ?? LocationServiceError.cantFindCityCoordinates)
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                for item in response.mapItems {
//                    print("coordinats: \(item.placemark.coordinate)")
                    self?.requestWeather(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                }
            }
        }
    }
    
    func requestWeather() {
        if currentCoordinates != nil {
            listWeatherForDays?.removeAll()
            mainViewClearShowingData()
            requestWeatherForLocation()
            return
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
            mainViewShowError(LocationServiceError.authorizationDenied)
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func requestWeatherForLocation() {
        guard let currentCoordinates = currentCoordinates else {
            mainViewShowError(LocationServiceError.currentCoordinatesMissed)
            return
        }
        let latitude = currentCoordinates.coordinate.latitude
        let longitude = currentCoordinates.coordinate.longitude
//        print ("\(latitude) | \(longitude)")
        
        requestWeather(latitude: latitude, longitude: longitude)
    }
    
    private func requestWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        weatherService.requestWeather(latitude: latitude, longitude: longitude) { [weak self] res, err in
            if let error = err {
                self?.mainViewShowError(error)
                print("requestWeather : \(error)")
            }
            
            if let result = res {
                let date = Date(timeIntervalSince1970: TimeInterval(result.dt ?? 0))
                let model = WeatherCurrent(date: date,
                                           temp: Int(round(result.main.temp ?? 0)),
                                           feelsLike: Int(round(result.main.feelsLike ?? 0)),
                                           tempMin: Int(round(result.main.tempMin ?? 0)),
                                           tempMax: Int(round(result.main.tempMax ?? 0)),
                                           windSpeed: Int(round(result.wind.speed ?? 0)),
                                           pressure: result.main.pressure ?? 0,
                                           humidity: result.main.humidity ?? 0,
                                           city: result.name ?? "",
                                           description: result.weather.first?.description ?? "",
                                           icon: self?.chooseIconForWeather(result.weather.first) ?? "")
                self?.mainViewShowCurrentWeather(model)
            }
        }
        
        weatherService.requestWeatherForDays(latitude: latitude, longitude: longitude) { [weak self] res, err in
            if let error = err {
                self?.mainViewShowError(error)
                print("requestWeatherForDays : \(error)")
            }
            
            if let result = res {
                var k = 2
                for i in 0..<result.list.count {
                    if k > result.list.count - 1 {
                        k = i
                    }
                    let date1 = Date(timeIntervalSince1970: TimeInterval(result.list[k].dt ?? 0))
                    let date2 = Date(timeIntervalSince1970: TimeInterval(result.list[i].dt ?? 0))
                    
                    if Calendar.current.compare(date1, to: date2, toGranularity: .day) == .orderedAscending {
                        k = i + 6
                    } else if k == i {
//                        print ("| \(date1) |")
                        let model = WeatherForDays(date: date1,
                                                   temp: Int(round(result.list[k].main.temp ?? 0)),
                                                   feelsLike: Int(round(result.list[k].main.feelsLike ?? 0)),
                                                   tempMin: Int(round(result.list[k].main.tempMin ?? 0)),
                                                   tempMax: Int(round(result.list[k].main.tempMax ?? 0)),
                                                   pressure: result.list[k].main.pressure ?? 0,
                                                   humidity: result.list[k].main.humidity ?? 0,
                                                   description: result.list[k].weather.first?.description ?? "",
                                                   icon: "\(self?.chooseIconForWeather(result.list[k].weather.first) ?? "")Small")
                        self?.listWeatherForDays?.append(model)
                        self?.mainViewShowResults()
                    }
                }
            }
        }
    }
    
    private func chooseIconForWeather(_ weather: Weather?) -> String {
        //https://openweathermap.org/weather-conditions
        var icon = "lightCloudy"
        if let weather = weather {
            if let id = weather.id {
                if id >= 200 && id <= 232 {
                    //иконка: гроза
                    icon = "lightning"
                } else if id >= 300 && id <= 321 {
                    //иконка: дождь
                    icon = "rainy"
                } else if id >= 500 && id <= 531 {
                    //иконка: дождь с солнцем
                    icon = "lighRain"
                } else if id >= 600 && id <= 622 {
                    //иконка: снег
                    icon = "snow"
                } else if id >= 700 && id <= 781 {
                    //иконка: туман
                    icon = "fog2"
                } else if id == 800 {
                    // иконка: ясное небо
                    icon = "sunny"
                } else if id == 801 {
                    // иконка: облако с солнцем
                    icon = "lightCloudy"
                } else if id >= 802 && id <= 804 {
                    // иконка: облако
                    icon = "cloudy"
                }
            }
        }
        return icon
    }
    
    private func mainViewShowError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.showError(error)
        }
    }
    
    private func mainViewShowResults() {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.showWeather()
        }
    }
    
    private func mainViewShowCurrentWeather(_ model: WeatherCurrent) {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.showCurrentWeather(model)
        }
    }
    
    private func mainViewClearShowingData() {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.clearShowingData()
        }
    }
}

//MARK: - CLLocationManagerDelegate
extension MainViewPresenter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty ,currentCoordinates == nil {
            currentCoordinates = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
            mainViewShowError(LocationServiceError.authorizationDenied)
        }
    }
}
