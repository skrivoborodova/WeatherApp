//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 21.03.2024.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol{
    
    var presenter: MainViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        presenter?.requestWeather()
    }
    
    func showSuccessResult() {
        
    }
    
    func showFailureResult() {
        
    }
    
    func showWaiting() {
        
    }
    
    func showEmptyResult() {
        
    }
    
}

