//
//  WeatherTableCell.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 22.03.2024.
//

import UIKit

final class WeatherTableCell: UITableViewCell {
    
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
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        backgroundConfiguration = .none
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(city: String?, date: String?, temp: Int?, maxTemp: Int?, minTemp: Int?, description: String?) {
        
        if let temp = temp,
           let maxTemp = maxTemp,
           let minTemp = minTemp {
            
            self.temp.text = "\(temp)°"
            self.maxTemp.text = "Макс.: \(maxTemp)°"
            self.minTemp.text = "Мин.: \(minTemp)°"
        }
        
        self.cityTitle.text = city
        self.dateTitle.text = date
        self.descriptionTitle.text = description
    }
}

extension WeatherTableCell {
    private func configureCell() {
        contentView.backgroundColor = .clear
        contentView.addSubviews([
            cityTitle,
            dateTitle,
            weatherImageView,
            temp,
            maxTemp,
            minTemp,
            descriptionTitle,
            
        ])
        
        NSLayoutConstraint.activate([
            cityTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cityTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            dateTitle.topAnchor.constraint(equalTo: cityTitle.bottomAnchor),
            dateTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            dateTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            weatherImageView.topAnchor.constraint(equalTo: dateTitle.bottomAnchor, constant: 16),
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            weatherImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
            weatherImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            
            temp.topAnchor.constraint(equalTo: weatherImageView.topAnchor),
            temp.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
            temp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            maxTemp.topAnchor.constraint(equalTo: temp.bottomAnchor),
            maxTemp.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
            maxTemp.trailingAnchor.constraint(equalTo: minTemp.leadingAnchor, constant: -6),
            
            minTemp.topAnchor.constraint(equalTo: maxTemp.topAnchor),
            minTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            minTemp.leadingAnchor.constraint(equalTo: maxTemp.trailingAnchor, constant: 6),
            
            descriptionTitle.topAnchor.constraint(equalTo: maxTemp.bottomAnchor),
            descriptionTitle.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 16),
            descriptionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
        ])
    }
}
