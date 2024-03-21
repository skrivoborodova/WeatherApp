//
//  Builder.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 21.03.2024.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    static func createMainModule() -> UIViewController
}

final class Builder: BuilderProtocol {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let service = WeatherService()
        let presenter = MainViewPresenter(view: view, weatherService: service)
        view.presenter = presenter
        
        return view
    }
}
