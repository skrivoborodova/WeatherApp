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
        if locationManager.authorizationStatus == .denied {
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
//                print(result)
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
//                        print ("||| \(date1) |||")
                        let model = WeatherForDays(date: date1,
                                                   temp: result.list[k].main.temp,
                                                   feelsLike: result.list[k].main.feelsLike,
                                                   tempMin: result.list[k].main.tempMin,
                                                   tempMax: result.list[k].main.tempMax,
                                                   pressure: result.list[k].main.pressure,
                                                   humidity: result.list[k].main.humidity,
                                                   description: result.list[k].weather.first?.description ?? "",
                                                   icon: result.list[k].weather.first?.icon ?? "")
                        self?.listWeatherForDays?.append(model)
                        self?.mainViewShowResults()
                    }
                }
            }
        }
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
}
