//
//  UIColor+Extension.swift
//  WeatherApp
//
//  Created by Светлана Кривобородова on 22.03.2024.
//

import UIKit

extension UIColor {
    
    public convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    static let linearGradient1: UIColor = UIColor(r: 75, g: 147, b: 225)
    static let linearGradient2: UIColor = UIColor(r: 146, g: 185, b: 228)
}

