//
//  WeatherModel.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

// MARK: - Weather City Group
struct WeatherCityGroup: Codable {
    let cnt: Int
    let list: [CityDetail]
}

// MARK: - Weather of city
struct WeatherOfCity: Codable {
    let coord: Coord
    let weather: [WeatherDetail]
    let base: String
    let main: WeatherMain
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - List
struct CityDetail: Codable {
    let coord: Coord
    let sys: Sys
    let weather: [WeatherDetail]
    let main: WeatherMain
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt, id: Int
    let name: String
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - WeatherMain
struct WeatherMain: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
    let timezone, sunrise, sunset: Int
}

// MARK: - WeatherDetail
struct WeatherDetail: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct OpenWeatherError: Codable {
    let cod: Int
    let message: String
}
