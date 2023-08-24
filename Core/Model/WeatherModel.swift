//
//  WeatherModel.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

// MARK: - Weather City Group
struct WeatherCityGroup: Codable {
    let count: Int
    let list: [WeatherOfCity]
    
    private enum CodingKeys: String, CodingKey {
        case list
        case count = "cnt"
    }
}

// MARK: - Weather of city
struct WeatherOfCity: Codable {
    let coord: Coordinates
    let sys: RegionDetails
    let weather: [WeatherDetail]
    let main: WeatherMain
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt, id: Int
    let name: String
    
    var cleanVisibility: Measurement<UnitLength> {
        return Measurement<UnitLength>(value: Double(visibility), unit: .meters)
    }
}

extension WeatherOfCity {
    static let mock = WeatherOfCity(
        coord: Coordinates(
            longitude: 11.9668,
            latitude: 57.7072
        ),
        sys: RegionDetails(
            country: "SE",
            timezone: 7200,
            sunrise: 1657074106,
            sunset: 1657138294
        ),
        weather: [
            WeatherDetail(
                id: 800,
                main: "Clear",
                weatherDescription: "clear sky",
                icon: "01d"
            )
        ],
        main: WeatherMain(
            temp: 18.04,
            feelsLike: 17.47,
            tempMin: 16.73,
            tempMax: 18.71,
            pressure: 1014,
            humidity: 60
        ),
        visibility: 10000,
        wind: Wind(
            speed: 6.69,
            degree: 280
        ),
        clouds: Clouds(all: 1),
        dt: 1657123756,
        id: 2711537,
        name: "Gothenburg"
    )
    
    static let mock2 = WeatherOfCity(
        coord: Coordinates(
            longitude: 51.4215,
            latitude: 35.6944
        ),
        sys: RegionDetails(
            country: "IR",
            timezone: 12600,
            sunrise: 1692755950,
            sunset: 1692803726
        ),
        weather: [
            WeatherDetail(
                id: 801,
                main: "Clouds",
                weatherDescription: "few clouds",
                icon: "02d"
            )
        ],
        main: WeatherMain(
            temp: 31.99,
            feelsLike: 29.75,
            tempMin: 31.99,
            tempMax: 31.99,
            pressure: 1017,
            humidity: 13
        ),
        visibility: 10000,
        wind: Wind(
            speed: 3.09,
            degree: 210
        ),
        clouds: Clouds(all: 1),
        dt: 1692770943,
        id: 112931,
        name: "Tehran"
    )
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}
