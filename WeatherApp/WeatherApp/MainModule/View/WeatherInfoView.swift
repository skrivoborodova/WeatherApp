//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 23.03.2024.
//

import UIKit

final class WeatherInfoView: UIView {
    
    private let heightOfIcon: CGFloat = 34
    
    //MARK: Temp Feels Like
    private lazy var weatherItemViewFeelsLike: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var feelsLikeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Wind Speed
    private lazy var weatherItemViewWindSpeed: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var windSpeedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var windSpeedLabelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: Humidity
    private lazy var weatherItemViewHum: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var humImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var humLabelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var humLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Pressure
    private lazy var weatherItemViewPress: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pressImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pressLabelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Line
    private lazy var line: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func setupView(feelsLike: Int?, windSpeed: Int?, humidity: Int?, pressure: Int?) {
        
        guard let feelsLike = feelsLike,
              let windSpeed = windSpeed,
              let humidity = humidity,
              let pressure = pressure
        else { return }
        
        line.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        feelsLikeImageView.image = UIImage(named: "temperature")
        feelsLikeLabel.text = "Ощущается как"
        feelsLikeTempLabel.text = "\(feelsLike)°"
        
        windSpeedImageView.image = UIImage(named: "wind")
        windSpeedLabelText.text = "Скорость ветра"
        windSpeedLabel.text = "\(windSpeed) м/с"
        
        humImageView.image = UIImage(named: "humidity")
        humLabelText.text = "Влажность"
        humLabel.text = "\(humidity) %"
        
        pressImageView.image = UIImage(named: "pressure")
        pressLabelText.text = "Давление"
        pressLabel.text = "\(pressure) мм.рт.ст."
    }
    
    private func configureView() {
        weatherItemViewFeelsLike.addSubviews([
            feelsLikeImageView,
            feelsLikeLabel,
            feelsLikeTempLabel
        ])
        
        weatherItemViewWindSpeed.addSubviews([
            windSpeedImageView,
            windSpeedLabelText,
            windSpeedLabel
        ])
        
        weatherItemViewHum.addSubviews([
            humImageView,
            humLabelText,
            humLabel
        ])
        
        weatherItemViewPress.addSubviews([
            pressImageView,
            pressLabelText,
            pressLabel
        ])
        
        self.addSubviews([
            weatherItemViewFeelsLike,
            weatherItemViewWindSpeed,
            weatherItemViewHum,
            weatherItemViewPress,
            line
        ])
        
        NSLayoutConstraint.activate([
            //feels like
            feelsLikeImageView.topAnchor.constraint(equalTo: weatherItemViewFeelsLike.topAnchor),
            feelsLikeImageView.leadingAnchor.constraint(equalTo: weatherItemViewFeelsLike.leadingAnchor),
            feelsLikeImageView.heightAnchor.constraint(equalToConstant: heightOfIcon),
            feelsLikeImageView.widthAnchor.constraint(equalToConstant: heightOfIcon),
            
            feelsLikeLabel.topAnchor.constraint(equalTo: weatherItemViewFeelsLike.topAnchor),
            feelsLikeLabel.leadingAnchor.constraint(equalTo: feelsLikeImageView.trailingAnchor, constant: 6),
            feelsLikeLabel.trailingAnchor.constraint(equalTo: weatherItemViewFeelsLike.trailingAnchor),
            
            feelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor),
            feelsLikeTempLabel.leadingAnchor.constraint(equalTo: feelsLikeImageView.trailingAnchor, constant: 6),
            feelsLikeTempLabel.trailingAnchor.constraint(equalTo: weatherItemViewFeelsLike.trailingAnchor),
            
            //wind speed
            windSpeedImageView.topAnchor.constraint(equalTo: weatherItemViewWindSpeed.topAnchor),
            windSpeedImageView.leadingAnchor.constraint(equalTo: weatherItemViewWindSpeed.leadingAnchor),
            windSpeedImageView.heightAnchor.constraint(equalToConstant: heightOfIcon),
            windSpeedImageView.widthAnchor.constraint(equalToConstant: heightOfIcon),
            
            windSpeedLabelText.topAnchor.constraint(equalTo: weatherItemViewWindSpeed.topAnchor),
            windSpeedLabelText.leadingAnchor.constraint(equalTo: windSpeedImageView.trailingAnchor, constant: 6),
            windSpeedLabelText.trailingAnchor.constraint(equalTo: weatherItemViewWindSpeed.trailingAnchor),
            
            windSpeedLabel.topAnchor.constraint(equalTo: windSpeedLabelText.bottomAnchor),
            windSpeedLabel.leadingAnchor.constraint(equalTo: windSpeedImageView.trailingAnchor, constant: 6),
            windSpeedLabel.trailingAnchor.constraint(equalTo: weatherItemViewWindSpeed.trailingAnchor),
            
            //hum
            humImageView.topAnchor.constraint(equalTo: weatherItemViewHum.topAnchor),
            humImageView.leadingAnchor.constraint(equalTo: weatherItemViewHum.leadingAnchor),
            humImageView.heightAnchor.constraint(equalToConstant: heightOfIcon),
            humImageView.widthAnchor.constraint(equalToConstant: heightOfIcon),
            
            humLabelText.topAnchor.constraint(equalTo: weatherItemViewHum.topAnchor),
            humLabelText.leadingAnchor.constraint(equalTo: humImageView.trailingAnchor, constant: 6),
            humLabelText.trailingAnchor.constraint(equalTo: weatherItemViewHum.trailingAnchor),
            
            humLabel.topAnchor.constraint(equalTo: humLabelText.bottomAnchor),
            humLabel.leadingAnchor.constraint(equalTo: humImageView.trailingAnchor, constant: 6),
            humLabel.trailingAnchor.constraint(equalTo: weatherItemViewHum.trailingAnchor),
            
            //press
            pressImageView.topAnchor.constraint(equalTo: weatherItemViewPress.topAnchor),
            pressImageView.leadingAnchor.constraint(equalTo: weatherItemViewPress.leadingAnchor),
            pressImageView.heightAnchor.constraint(equalToConstant: heightOfIcon),
            pressImageView.widthAnchor.constraint(equalToConstant: heightOfIcon),
            
            pressLabelText.topAnchor.constraint(equalTo: weatherItemViewPress.topAnchor),
            pressLabelText.leadingAnchor.constraint(equalTo: pressImageView.trailingAnchor, constant: 6),
            pressLabelText.trailingAnchor.constraint(equalTo: weatherItemViewPress.trailingAnchor),
            
            pressLabel.topAnchor.constraint(equalTo: pressLabelText.bottomAnchor),
            pressLabel.leadingAnchor.constraint(equalTo: pressImageView.trailingAnchor, constant: 6),
            pressLabel.trailingAnchor.constraint(equalTo: weatherItemViewPress.trailingAnchor),
            
            
            line.widthAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            line.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            weatherItemViewFeelsLike.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            weatherItemViewFeelsLike.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            weatherItemViewFeelsLike.trailingAnchor.constraint(equalTo: line.leadingAnchor, constant: -12),
            weatherItemViewFeelsLike.heightAnchor.constraint(equalToConstant: heightOfIcon),
            
            weatherItemViewWindSpeed.topAnchor.constraint(equalTo: weatherItemViewFeelsLike.bottomAnchor, constant: 12),
            weatherItemViewWindSpeed.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            weatherItemViewWindSpeed.trailingAnchor.constraint(equalTo: line.leadingAnchor, constant: -12),
            weatherItemViewWindSpeed.heightAnchor.constraint(equalToConstant: heightOfIcon),
            
            weatherItemViewHum.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            weatherItemViewHum.leadingAnchor.constraint(equalTo: line.trailingAnchor, constant: 12),
            weatherItemViewHum.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            weatherItemViewHum.heightAnchor.constraint(equalToConstant: heightOfIcon),
            
            weatherItemViewPress.topAnchor.constraint(equalTo: weatherItemViewHum.bottomAnchor, constant: 12),
            weatherItemViewPress.leadingAnchor.constraint(equalTo: line.trailingAnchor, constant: 12),
            weatherItemViewPress.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            weatherItemViewPress.heightAnchor.constraint(equalToConstant: heightOfIcon),
        ])
    }
    
}
