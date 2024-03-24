//
//  Errors.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 24.03.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseFailureStatusCode
}

enum LocationServiceError: Error {
    case authorizationDenied
    case currentCoordinatesMissed
    case cantFindCityCoordinates
}
