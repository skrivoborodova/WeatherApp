//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 21.03.2024.
//

import Foundation
import CoreLocation

enum WeatherServiceError: Error {
    case authorizationDenied
    case currentCoordinatesMissed
}

protocol WeatherServiceProtocol: AnyObject {
    func requestWeather()
}

final class WeatherService: NSObject {
    private let network = NetworkCore.shared
    private let locationManager = CLLocationManager()
    
    private var currentCoordinates: CLLocation?
    
    var weather: WeatherResults?
    var error: Error?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
}

//MARK: - WeatherServiceProtocol
extension WeatherService: WeatherServiceProtocol {
    
    func requestWeather() {
        locationManager.requestWhenInUseAuthorization()
        if locationManager.authorizationStatus == .denied {
            error = WeatherServiceError.authorizationDenied
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func requestWeatherForLocation() {
        guard let currentCoordinates = currentCoordinates else {
            error = WeatherServiceError.currentCoordinatesMissed
            return
        }
        let longitude = currentCoordinates.coordinate.longitude
        let latitude = currentCoordinates.coordinate.latitude
        
        print ("\(longitude) | \(latitude)")
        
        let matadata = "lat=\(latitude)&lon=\(longitude)&units=metric&lang=ru"
        
        network.request(metadata: matadata) { [weak self] (result: Result<WeatherResults, Error>) in
            switch result {
            case .success(let response):
                self?.weather = response
                print(response)
            case .failure(let error):
                self?.error = error
                print(error)
            }
        }
    }
    
}

//MARK: - CLLocationManagerDelegate
extension WeatherService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty ,currentCoordinates == nil {
            currentCoordinates = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
}
