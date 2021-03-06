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
    
    var cleanVisibility: Measurement<UnitLength> {
        return Measurement<UnitLength>(value: Double(visibility), unit: .meters)
    }
}

extension CityDetail {
    static let mock = CityDetail(
        coord: Coord(
            lon: 11.9668,
            lat: 57.7072
        ),
        sys: Sys(
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
            deg: 280
        ),
        clouds: Clouds(all: 1),
        dt: 1657123756,
        id: 2711537,
        name: "Gothenburg"
    )
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
    
    var cleanTemp: Measurement<UnitTemperature> {
        return cleanTemp(temp)
    }
    
    var cleanFeelsLike: Measurement<UnitTemperature> {
        return cleanTemp(feelsLike)
    }
    
    var cleanTempMin: Measurement<UnitTemperature> {
        return cleanTemp(tempMin)
    }
    
    var cleanTempMax: Measurement<UnitTemperature> {
        return cleanTemp(tempMax)
    }
    
    var cleanPressure: Measurement<UnitPressure> {
        return Measurement<UnitPressure>(value: Double(pressure), unit: .bars)
    }
}

extension WeatherMain {
    func cleanTemp(_ temp: Double) -> Measurement<UnitTemperature> {
        return Measurement<UnitTemperature>(value: temp, unit: .celsius)
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
    let timezone: Int?
    let sunrise, sunset: Int
    
    var sunRiseDate: String {
        return timezoneFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(sunrise)))
    }
    
    var sunsetDate: String {
        return timezoneFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(sunset)))
    }
    
    private var timezoneFormatter: DateFormatter {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateStyle = .none
        utcDateFormatter.timeStyle = .short
        utcDateFormatter.timeZone = TimeZone(secondsFromGMT: timezone ?? 0)
        return utcDateFormatter
    }
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
    
    var iconURL: URL {
        return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!
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

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    
    var cleanSpeed: Measurement<UnitSpeed> {
        return Measurement<UnitSpeed>(value: speed, unit: .kilometersPerHour)
    }
}

struct OpenWeatherError: Codable {
    let cod: Int
    let message: String
}
