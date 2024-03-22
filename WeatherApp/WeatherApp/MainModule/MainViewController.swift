//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 21.03.2024.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainViewPresenterProtocol?
    
    private let cellId = "cellId"
    
    private lazy var weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(WeatherTableCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        presenter?.requestWeather()
        
        configureTableView()
    }
    
    private func configureTableView() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(weatherTableView)

        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}


// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    
    func showWeather() {
        weatherTableView.reloadData()
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.listWeatherForDays?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WeatherTableCell
//        let description = presenter?.listWeatherForDays?[indexPath.row].description
//        cell.setupCell(title: description)
        let date = presenter?.listWeatherForDays?[indexPath.row].date.toString()
        cell.setupCell(title: date)
        return cell
    }
}
