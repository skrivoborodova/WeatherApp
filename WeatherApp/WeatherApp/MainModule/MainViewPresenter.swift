//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 21.03.2024.
//

import Foundation
import CoreLocation

enum LocationServiceError: Error {
    case authorizationDenied
    case currentCoordinatesMissed
}

protocol MainViewProtocol: AnyObject {
    func showCurrentWeather(_ model: WeatherCurrent)
    func showWeather()
    func showError(_ error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, weatherService: WeatherServiceProtocol)
    func requestWeather()
    
    var listWeatherForDays: [WeatherForDays]? { get }
}

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
    
    func requestWeather() {
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
        
        print ("\(latitude) | \(longitude)")
        
        weatherService.requestWeather(latitude: latitude, longitude: longitude) { [weak self] res, err in
            if let error = err {
                self?.mainViewShowError(error)
                print("requestWeather : \(error)")
            }
            
            if let result = res {
                let date = Date(timeIntervalSince1970: TimeInterval(result.dt))
                let model = WeatherCurrent(date: date,
                                           temp: Int(round(result.main.temp)),
                                           feelsLike: Int(round(result.main.feelsLike)),
                                           tempMin: Int(round(result.main.tempMin)),
                                           tempMax: Int(round(result.main.tempMax)),
                                           windSpeed: Int(round(result.wind.speed)),
                                           pressure: result.main.pressure,
                                           humidity: result.main.humidity,
                                           city: result.name,
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
                    let date1 = Date(timeIntervalSince1970: TimeInterval(result.list[k].dt))
                    let date2 = Date(timeIntervalSince1970: TimeInterval(result.list[i].dt))
                    
                    if Calendar.current.compare(date1, to: date2, toGranularity: .day) == .orderedAscending {
                        k = i + 6
                    } else if k == i {
//                        print ("| \(date1) |")
                        let model = WeatherForDays(date: date1,
                                                   temp: Int(round(result.list[k].main.temp)),
                                                   feelsLike: Int(round(result.list[k].main.feelsLike)),
                                                   tempMin: Int(round(result.list[k].main.tempMin)),
                                                   tempMax: Int(round(result.list[k].main.tempMax)),
                                                   pressure: result.list[k].main.pressure,
                                                   humidity: result.list[k].main.humidity,
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
            
//            print ("weather id: \(weather.id)")
            
            if weather.id >= 200 && weather.id <= 232 {
                //иконка: гроза
                icon = "lightning"
            } else if weather.id >= 300 && weather.id <= 321 {
                //иконка: дождь
                icon = "rainy"
            } else if weather.id >= 500 && weather.id <= 531 {
                //иконка: дождь с солнцем
                icon = "lighRain"
            } else if weather.id >= 600 && weather.id <= 622 {
                //иконка: снег
                icon = "snow"
            } else if weather.id >= 700 && weather.id <= 781 {
                //иконка: туман
                icon = "fog2"
            } else if weather.id == 800 {
                // иконка: ясное небо
                icon = "sunny"
            } else if weather.id == 801 {
                // иконка: облако с солнцем
                icon = "lightCloudy"
            } else if weather.id >= 802 && weather.id <= 804 {
                // иконка: облако
                icon = "cloudy"
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
