//
//  AppService.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

struct AppService {
    static var openWeatherAPIKey: String {
        if let apiKey = Bundle.main.infoDictionary?["OPEN_WEATHER_API_KEY"] as? String {
            return apiKey
        }
        return ""
    }
}
