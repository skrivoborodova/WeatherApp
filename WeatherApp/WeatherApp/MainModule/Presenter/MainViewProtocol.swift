//
//  MainViewProtocol.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 24.03.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func showCurrentWeather(_ model: WeatherCurrent)
    func showWeather()
    func showError(_ error: Error)
    func clearShowingData()
}
