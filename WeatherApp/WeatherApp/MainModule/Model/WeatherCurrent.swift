//
//  WeatherCurrent.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 22.03.2024.
//

import Foundation

struct WeatherCurrent {
    let date: Date
    let temp, feelsLike, tempMin, tempMax, windSpeed: Int
    let pressure, humidity: Int
    let city, description, icon: String
}
