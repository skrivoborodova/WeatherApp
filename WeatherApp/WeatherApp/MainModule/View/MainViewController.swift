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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(WeatherTableCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white.withAlphaComponent(0.2)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var cityTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temp: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 80, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var maxTemp: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var minTemp: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var weatherInfoView: WeatherInfoView = {
        let view = WeatherInfoView()
        view.layer.cornerRadius = 14
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerTableView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.requestWeather()
        configureView()
    }
    
    private func configureView() {
        view.applyGradient(isVertical: true, colorArray: [UIColor.linearGradient1, UIColor.linearGradient2])
        view.addSubviews([
            cityTitle,
            dateTitle,
            weatherImageView,
            temp,
            maxTemp,
            minTemp,
            descriptionTitle,
            weatherInfoView,
            containerTableView,
        ])
        containerTableView.addSubview(weatherTableView)

        NSLayoutConstraint.activate([
            cityTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cityTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            cityTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            dateTitle.topAnchor.constraint(equalTo: cityTitle.bottomAnchor),
            dateTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            dateTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            weatherImageView.topAnchor.constraint(equalTo: dateTitle.bottomAnchor, constant: 16),
            weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            weatherImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
            weatherImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            
            temp.topAnchor.constraint(equalTo: weatherImageView.topAnchor),
            temp.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
            temp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            maxTemp.topAnchor.constraint(equalTo: temp.bottomAnchor),
            maxTemp.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
            maxTemp.trailingAnchor.constraint(equalTo: minTemp.leadingAnchor, constant: -6),
            
            minTemp.topAnchor.constraint(equalTo: maxTemp.topAnchor),
            minTemp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            minTemp.leadingAnchor.constraint(equalTo: maxTemp.trailingAnchor, constant: 6),
            
            descriptionTitle.topAnchor.constraint(equalTo: maxTemp.bottomAnchor),
            descriptionTitle.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
            descriptionTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            weatherInfoView.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 16),
            weatherInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weatherInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            weatherInfoView.heightAnchor.constraint(equalToConstant: 120),
            
            containerTableView.topAnchor.constraint(equalTo: weatherInfoView.bottomAnchor, constant: 16),
            containerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            containerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            weatherTableView.topAnchor.constraint(equalTo: containerTableView.topAnchor, constant: 16),
            weatherTableView.leadingAnchor.constraint(equalTo: containerTableView.leadingAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: containerTableView.trailingAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: containerTableView.bottomAnchor),
        ])
    }
}


// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    
    func showCurrentWeather(_ model: WeatherCurrent) {
        self.weatherImageView.image = UIImage(named: model.icon)
        self.cityTitle.text = model.city
        self.dateTitle.text = model.date.toString()
        self.temp.text = "\(model.temp)°"
        self.maxTemp.text = "Макс.: \(model.tempMax)°"
        self.minTemp.text = "Мин.: \(model.tempMin)°"
        self.descriptionTitle.text = model.description
        self.weatherInfoView.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        self.weatherInfoView.setupView(feelsLike: model.feelsLike, windSpeed: model.windSpeed, humidity: model.humidity, pressure: model.pressure)
    }
    
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
        cell.setupCell(date: presenter?.listWeatherForDays?[indexPath.row].date.toString(),
                       tempMin: presenter?.listWeatherForDays?[indexPath.row].tempMin,
                       tempMax: presenter?.listWeatherForDays?[indexPath.row].tempMax,
                       icon: presenter?.listWeatherForDays?[indexPath.row].icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
}
