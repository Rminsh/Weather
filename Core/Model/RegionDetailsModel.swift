//
//  RegionDetailsModel.swift
//  Weather
//
//  Created by Armin on 7/27/22.
//

import Foundation

// MARK: - RegionDetails
struct RegionDetails: Codable {
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

// MARK: - Coordinates
struct Coordinates: Codable {
    let longitude, latitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
