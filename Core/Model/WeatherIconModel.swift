//
//  WeatherIconModel.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import SwiftUI

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
            return "cloud.rain.fill"
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
    
    var gradients: [Color] {
        switch self {
        case .clearSkyDay:
            return [Color("ClearDayStart"), Color("ClearDayEnd")]
        case .clearSkyNight:
            return [Color("ClearNightStart"), Color("ClearNightEnd")]
        case .fewCloudsDay:
            return [Color("ClearDayStart"), Color("ClearDayEnd")]
        case .fewCloudsNight:
            return [Color("ClearNightStart"), Color("ClearNightEnd")]
        case .scatteredClouds:
            return [Color("ClearDayStart"), Color("ClearDayEnd")]
        case .brokenClouds:
            return [Color("ClearDayStart"), Color("ClearDayEnd")]
        case .showerRain:
            return [Color("RainyStart"), Color("RainyEnd")]
        case .rain:
            return [Color("RainyStart"), Color("RainyEnd")]
        case .thunderstorm:
            return [Color("SnowStart"), Color("SnowMiddle"), Color("SnowEnd")]
        case .snow:
            return [Color("SnowStart"), Color("SnowMiddle"), Color("SnowEnd")]
        case .mist:
            return [Color("SnowStart"), Color("SnowMiddle"), Color("SnowEnd")]
        case .unknown:
            return [.blue, .cyan]
        }
    }
}
