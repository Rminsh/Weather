//
//  WeatherMainModel.swift
//  Weather
//
//  Created by Armin on 7/30/22.
//

import Foundation

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
