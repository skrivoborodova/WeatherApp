//
//  WeatherTableCell.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 22.03.2024.
//

import UIKit

final class WeatherTableCell: UITableViewCell {

    private lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temp: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
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
    
    func setupCell(date: String?, tempMin: Int?, tempMax: Int?, icon: String?) {
        self.dateTitle.text = date
        if let tempMin = tempMin,
           let tempMax = tempMax {
            self.temp.text = "от \(tempMin)° до \(tempMax)°"
        }
        if let icon = icon {
            self.weatherImageView.image = UIImage(named: icon)
        }
    }
}

extension WeatherTableCell {
    private func configureCell() {
        contentView.backgroundColor = .clear
        contentView.addSubviews([
            dateTitle,
            weatherImageView,
            temp,
        ])
        
        NSLayoutConstraint.activate([
            dateTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            dateTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 24),
            weatherImageView.heightAnchor.constraint(equalToConstant: 24),

            temp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            temp.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 24),
            temp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
}
