//
//  WeatherForDays.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 22.03.2024.
//

import Foundation

struct WeatherForDays {
    let date: Date
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    let description, icon: String
}
