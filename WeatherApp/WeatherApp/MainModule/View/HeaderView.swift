//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 23.03.2024.
//

import UIKit

final class HeaderView: UIView {
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = UIColor.clear.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.image = UIImage(named: "calendar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
            
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.lightBlue
        label.numberOfLines = 0
        label.text = "Прогноз на 5 дней".uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        self.addSubviews([
            icon,
            label
        ])
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            icon.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -3),
            
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 3),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
}
