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
    func showSuccessResult()
    func showFailureResult()
    func showWaiting()
    func showEmptyResult()
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, weatherService: WeatherServiceProtocol)
    func requestWeather()
}

final class MainViewPresenter: NSObject, MainViewPresenterProtocol {
    private let mainView: MainViewProtocol
    private let weatherService: WeatherServiceProtocol
    
    private let locationManager: CLLocationManager
    private var currentCoordinates: CLLocation?
    
    
    
    init(view: MainViewProtocol, weatherService: WeatherServiceProtocol) {
        self.mainView = view
        self.weatherService = weatherService
        
        self.locationManager = CLLocationManager()
    }
    
    func requestWeather() {
        // проверка на интернет
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if locationManager.authorizationStatus == .denied {
//            error = LocationServiceError.authorizationDenied
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func requestWeatherForLocation() {
        guard let currentCoordinates = currentCoordinates else {
//            error = LocationServiceError.currentCoordinatesMissed
            return
        }
        let latitude = currentCoordinates.coordinate.latitude
        let longitude = currentCoordinates.coordinate.longitude
        
        
        print ("\(latitude) | \(longitude)")
        
//        weatherService.requestWeather(latitude: latitude, longitude: longitude) { [weak self] res, err in
//            if let error = err {
//                self?.mainView.showFailureResult()
//                print(error)
//            }
//            
//            if let result = res {
//                print(result)
//            }
//        }
        
        weatherService.requestWeatherForDays(latitude: latitude, longitude: longitude) { [weak self] res, err in
            if let error = err {
                self?.mainView.showFailureResult()
                print(error)
            }
            
            if let result = res {
                print(result.list.first)
            }
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
