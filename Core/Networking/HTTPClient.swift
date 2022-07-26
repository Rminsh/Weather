//
//  HTTPClient.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T {
        
        var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path)
        
        if let urlParams = endpoint.urlParams {
            urlComponents?.queryItems = urlParams
        }
        
        guard let url = urlComponents?.url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.header
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    return decodedResponse
                } catch {
                    #if DEBUG
                    print("💥 Execute error:")
                    print(error)
                    #endif
                    throw RequestError.decode
                }
            case 400, 401:
                throw RequestError.unauthorized(data)
            case 404:
                throw RequestError.notFound
            default:
                throw RequestError.unexpectedStatusCode(response.statusCode)
            }
        } catch {
            throw RequestError.unknown("Network error")
        }
    }
}

