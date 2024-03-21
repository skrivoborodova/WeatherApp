//
//  ViewController.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 21.03.2024.
//

import UIKit

class ViewController: UIViewController {

    private let weatherService: WeatherServiceProtocol = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        weatherService.requestWeather()
    }


}

