//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 21.03.2024.
//

import Foundation

protocol WeatherServiceProtocol: AnyObject {
    func requestWeather(latitude: Double, longitude: Double, completion: @escaping (_ res: WeatherResults?, _ err: Error?) -> Void)
    func requestWeatherForDays(latitude: Double, longitude: Double, completion: @escaping (_ res: WeatherForDaysResults?, _ err: Error?) -> Void)
}

final class WeatherService {
    private let network = NetworkCore.shared
}

//MARK: - WeatherServiceProtocol
extension WeatherService: WeatherServiceProtocol {
    
    func requestWeather(latitude: Double, longitude: Double, completion: @escaping (_ res: WeatherResults?, _ err: Error?) -> Void) {
        let currentMetadata = "weather?lat=\(latitude)&lon=\(longitude)&units=metric&lang=ru"
        
        network.request(metadata: currentMetadata) { (result: Result<WeatherResults, Error>) in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func requestWeatherForDays(latitude: Double, longitude: Double, completion: @escaping (_ res: WeatherForDaysResults?, _ err: Error?) -> Void) {
        //на бесплатной версии API доступно только 5 дней
        let dailyMetadata = "forecast?lat=\(latitude)&lon=\(longitude)&units=metric&lang=ru"
        
        network.request(metadata: dailyMetadata) { (result: Result<WeatherForDaysResults, Error>) in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
