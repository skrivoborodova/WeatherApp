//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 22.03.2024.
//

import Foundation

extension Date {
    
    func toString(format: String = "dd.MM.yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
