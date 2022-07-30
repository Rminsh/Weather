//
//  OpenWeatherErrorModel.swift
//  Weather
//
//  Created by Armin on 7/27/22.
//

import Foundation

struct OpenWeatherError: Codable {
    let code: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
    }
}
