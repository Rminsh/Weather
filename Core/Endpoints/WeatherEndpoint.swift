//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

enum WeatherEndpoint {
    case weatherGroup(
        cityIDs: [String],
        unit: String
    )
    
    case currentWeatherCity(
        city: String,
        unit: String
    )
}

extension WeatherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .weatherGroup(_, _):
            return "group"
        case .currentWeatherCity(_, _):
            return "weather"
        }
    }
    
    var header: [String : String]? {
        return ["Content-Type":"\(HTTPContentType.applicationJSON); \(HTTPContentType.charsetUTF8)"]
    }
    
    var urlParams: [URLQueryItem]? {
        switch self {
        case .weatherGroup(let cityIDs, let unit):
            return [
                URLQueryItem(name: "id", value: cityIDs.joined(separator: ",")),
                URLQueryItem(name: "units", value: unit),
                URLQueryItem(name: "appid", value: AppService.openWeatherAPIKey)
            ]
        case .currentWeatherCity(let city, let unit):
            return [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "units", value: unit),
                URLQueryItem(name: "appid", value: AppService.openWeatherAPIKey)
            ]
        }
    }
}
