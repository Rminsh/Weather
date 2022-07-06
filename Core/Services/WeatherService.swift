//
//  WeatherService.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

protocol WeatherServiceable {
    func getWeatherGroup(
        cities: [String],
        unit: String
    ) async throws -> Result<WeatherCityGroup, RequestError>
    
    func getWeatherOfCity(
        city: String,
        unit: String
    ) async throws -> Result<WeatherOfCity, RequestError>
}

struct WeatherService: HTTPClient, WeatherServiceable {
    func getWeatherGroup(
        cities: [String],
        unit: String
    ) async throws -> Result<WeatherCityGroup, RequestError> {
        return try await sendRequest(
            endpoint: WeatherEndpoint.weatherGroup(cityIDs: cities, unit: unit),
            responseModel: WeatherCityGroup.self
        )
    }
    
    func getWeatherOfCity(city: String, unit: String) async throws -> Result<WeatherOfCity, RequestError> {
        return try await sendRequest(
            endpoint: WeatherEndpoint.currentWeatherCity(city: city, unit: unit),
            responseModel: WeatherOfCity.self
        )
    }
    
    static func getIcon(icon: String) -> WeatherIconModel {
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
