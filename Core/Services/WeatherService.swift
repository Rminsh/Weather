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
}
