//
//  RequestError.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case notFound
    case unauthorized(Data)
    case unexpectedStatusCode(Int)
    case unknown(String)
}
