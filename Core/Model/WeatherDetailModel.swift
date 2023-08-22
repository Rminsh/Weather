//
//  WeatherDetailModel.swift
//  Weather
//
//  Created by Armin on 7/27/22.
//

import Foundation

// MARK: - WeatherDetail
struct WeatherDetail: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    var symbolIcon: WeatherIconModel {
        switch icon {
        case "01d":
            return .clearSkyDay
        case "01n":
            return .clearSkyNight
        case "02d":
            return .fewCloudsDay
        case "02n":
            return .fewCloudsNight
        case "03d", "03n":
            return .scatteredClouds
        case "04d", "04n":
            return .brokenClouds
        case "09d", "09n":
            return .showerRain
        case "10d", "10n":
            return .rain
        case "11d", "11n":
            return .thunderstorm
        case "13d", "13n":
            return .snow
        case "50d", "50n":
            return .mist
        default:
            return .unknown
        }
    }
}
