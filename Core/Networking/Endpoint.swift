//
//  Endpoint.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

public protocol Endpoint {
    var baseURL:   String            { get }
    var path:      String            { get }
    var header:    [String: String]? { get }
    var urlParams: [URLQueryItem]?   { get }
    var body:      [String: Any]?    { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
}
