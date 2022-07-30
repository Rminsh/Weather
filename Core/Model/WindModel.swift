//
//  WindModel.swift
//  Weather
//
//  Created by Armin on 7/30/22.
//

import Foundation

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let degree: Int
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
    
    var cleanSpeed: Measurement<UnitSpeed> {
        return Measurement<UnitSpeed>(value: speed, unit: .kilometersPerHour)
    }
}
