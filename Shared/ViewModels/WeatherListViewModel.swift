//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import Foundation

class WeatherListViewModel: ObservableObject {
    
    @Published var cities: [CityDetail] = [CityDetail]()
    
    @Published var loading: Bool = false
    @Published var error: String? = nil
    
    private var weatherService = WeatherService()
    
    func getListData() async {
        Task(priority: .background) {
            let result = try await weatherService.getWeatherGroup(
                cities: ["2711537","2673730","5375480","2643743","5128581","2950159"],
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
    
    func decodeErrorMessage(_ data: Data) async throws -> String {
        do {
            return try JSONDecoder().decode(OpenWeatherError.self, from: data).message
        } catch {
            return "Failed to execute error, Try again"
        }
    }
    
    func setErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            print(message)
            //self.errorMessage = message
        }
    }
    
    func cleanTemp(_ temp: Double) -> Measurement<UnitTemperature> {
        return Measurement<UnitTemperature>(value: temp, unit: .celsius)
    }
}
