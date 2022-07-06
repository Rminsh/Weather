//
//  WeatherIconModel.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

enum WeatherIconModel: String {
    case clearSkyDay
    case clearSkyNight
    
    case fewCloudsDay
    case fewCloudsNight
    
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case thunderstorm
    case snow
    case mist
    
    case unknown
    
    var symbol: String {
        switch self {
        case .clearSkyDay:
            return "sun.max.fill"
        case .clearSkyNight:
            return "moon.fill"
        case .fewCloudsDay:
            return "cloud.sun.fill"
        case .fewCloudsNight:
            return "cloud.moon.fill"
        case .scatteredClouds:
            return "cloud.fill"
        case .brokenClouds:
            return "smoke.fill"
        case .showerRain:
            return "cloud.heavyrain.fill"
        case .rain:
            return "cloud.rain"
        case .thunderstorm:
            return "cloud.bolt.rain.fill"
        case .snow:
            return "snowflake"
        case .mist:
            return "cloud.fog.fill"
        case .unknown:
            return "questionmark.circle.fill"
        }
    }
}
