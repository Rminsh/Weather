//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import SwiftUI

class WeatherListViewModel: ObservableObject {
    
    @AppStorage("savedCities") var savedCities: [String] = [
        "2711537", // Gothenburg
        "2673730", // Stockholm
        "5375480", // Mountain View
        "2643743", // London
        "5128581", // New York
        "2950159"  // Berlin
    ]
    
    // WeatherList
    @Published var cities: [CityDetail] = [CityDetail]()
    @Published var loading: Bool = false
    @Published var error: String? = nil
    
    // AddCity
    @Published var showAddCityView: Bool = false
    @Published var addCityName: String = ""
    @Published var addLoading: Bool = false
    @Published var addError: String = ""
    
    private var weatherService = WeatherService()
    
    func getListData() async {
        DispatchQueue.main.async {
            self.error = nil
        }
        
        Task(priority: .background) {
            let result = try await weatherService.getWeatherGroup(
                cities: savedCities,
                unit: "metric"
            )
            
            DispatchQueue.main.async {
                self.loading = false
            }
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.cities = response.list
                }
            case .failure(let error):
                switch error {
                case .decode:
                    setErrorMessage("Failed to execute, try later")
                case .invalidURL:
                    setErrorMessage("Invalid URL")
                case .noResponse:
                    setErrorMessage("Network error, Try again")
                case .notFound:
                    setErrorMessage("Not found")
                case .unauthorized(let data):
                    setErrorMessage(try await decodeErrorMessage(data))
                case .unexpectedStatusCode(let status):
                    setErrorMessage("Unexpected Status Code \(status) occured")
                case .unknown(_):
                    setErrorMessage("Network error, Try again")
                }
            }
        }
    }
    
    func addCity() async {
        if addCityName == "" {
            return
        }
        
        DispatchQueue.main.async {
            self.addError = ""
            self.addLoading = true
        }
        
        Task(priority: .background) {
            let result = try await weatherService.getWeatherOfCity(
                city: addCityName,
                unit: "metric"
            )
            
            DispatchQueue.main.async {
                self.addLoading = false
            }
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.savedCities.append(String(response.id))
                    self.showAddCityView = false
                    self.addCityName = ""
                    self.cities.removeAll()
                    Task.init {
                        await self.getListData()
                    }
                }
            case .failure(let error):
                switch error {
                case .decode:
                    setAddErrorMessage("Failed to execute, try later")
                case .invalidURL:
                    setAddErrorMessage("Invalid URL")
                case .noResponse:
                    setAddErrorMessage("Network error, Try again")
                case .notFound:
                    setAddErrorMessage("City Not found")
                case .unauthorized(let data):
                    setAddErrorMessage(try await decodeErrorMessage(data))
                case .unexpectedStatusCode(let status):
                    setAddErrorMessage("Unexpected Status Code \(status) occured")
                case .unknown(_):
                    setAddErrorMessage("Network error, Try again")
                }
            }
        }
    }
    
    func decodeErrorMessage(_ data: Data) async throws -> String {
        do {
            return try JSONDecoder().decode(OpenWeatherError.self, from: data).message
        } catch {
            return "Failed to execute error, Try again"
        }
    }
    
    func setErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.error = message
        }
    }
    
    func setAddErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.addError = message
        }
    }
}
