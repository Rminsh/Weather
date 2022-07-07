//
//  WeatherDetailView.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import SwiftUI

struct WeatherDetailView: View {
    
    @State var city: CityDetail
    
    var mf: MeasurementFormatter {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        return mf
    }
    
    let layout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: WeatherService.getIcon(icon: city.weather.first?.icon ?? "").gradients),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 8) {
                    // MARK: - City name
                    #if os(macOS)
                    Text(city.name)
                        .font(.title2)
                        .dynamicTypeSize(.xSmall ... .large)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                    #endif
                    
                    // MARK: - Weather symbol
                    Image(systemName: WeatherService.getIcon(icon: city.weather.first?.icon ?? "").symbol)
                        .font(.system(size: 120))
                        .dynamicTypeSize(.xSmall ... .xxLarge)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                        .symbolRenderingMode(.multicolor)
                        .shadow(radius: 1)
                        .padding(.vertical, 50)
                        .padding(.horizontal)
                    
                    // MARK: - Weather temp
                    Text(mf.string(from: city.main.cleanTemp))
                        .font(.system(size: 60))
                        .dynamicTypeSize(.xSmall ... .xxLarge)
                    
                    // MARK: - Weather status
                    Text(city.weather.first?.main ?? "--")
                        .font(.title)
                        .dynamicTypeSize(.xSmall ... .large)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                    
                    HStack {
                        // MARK: - Low temp
                        Text("H:\(mf.string(from: city.main.cleanTempMax))")
                        
                        // MARK: - High temp
                        Text("L:\(mf.string(from: city.main.cleanTempMin))")
                    }
                    .padding(.vertical)
                    
                    LazyVGrid(columns: layout) {
                        // MARK: - Wind
                        WeatherItemDetailView(
                            icon: "wind",
                            title: "WIND",
                            value: mf.string(from: city.wind.cleanSpeed)
                        )
                        // MARK: - Humidity
                        WeatherItemDetailView(
                            icon: "humidity.fill",
                            title: "HUMIDITY",
                            value: "\(city.main.humidity.formatted())%"
                        )
                        // MARK: - FeelsLike
                        WeatherItemDetailView(
                            icon: "thermometer",
                            title: "FEELS LIKE",
                            value: mf.string(from: city.main.cleanFeelsLike)
                        )
                        // MARK: - Pressure
                        WeatherItemDetailView(
                            icon: "gauge.medium",
                            title: "PRESSURE",
                            value: mf.string(from: city.main.cleanPressure)
                        )
                        // MARK: - Visibility
                        WeatherItemDetailView(
                            icon: "eye.fill",
                            title: "VISIBILITY",
                            value: mf.string(from: city.cleanVisibility)
                        )
                    }
                    .padding()
                }
            }
        }
        #if os(iOS)
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
        #else
        .environment(\.colorScheme, .dark)
        #endif
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherDetailView(
                city: CityDetail.mock
            )
        }
    }
}
