//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 22.03.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
