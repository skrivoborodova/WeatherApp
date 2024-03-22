//
//  WeatherTableCell.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 22.03.2024.
//

import UIKit

final class WeatherTableCell: UITableViewCell {

    private lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(title: String?) {
        descriptionTitle.text = title
    }
}

extension WeatherTableCell {
    private func configureCell() {
        contentView.backgroundColor = .clear
        contentView.addSubviews([
            descriptionTitle,

        ])
        
        NSLayoutConstraint.activate([
            descriptionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
}
