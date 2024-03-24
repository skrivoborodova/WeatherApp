//
//  MainViewPresenterProtocol.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 24.03.2024.
//

import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, weatherService: WeatherServiceProtocol)
    func requestWeather()
    func seacrhWeather(_ text: String)
    
    var listWeatherForDays: [WeatherForDays]? { get }
}
