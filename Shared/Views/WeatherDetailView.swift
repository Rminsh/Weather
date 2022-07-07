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
                    Image(systemName: WeatherService.getIcon(icon: city.weather.first?.icon ?? "").symbol)
                        .font(.system(size: 120))
                        .dynamicTypeSize(.xSmall ... .xxLarge)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                        .symbolRenderingMode(.multicolor)
                        .shadow(radius: 1)
                        .padding(.vertical, 50)
                        .padding(.horizontal)
                    
                    Text(mf.string(from: cleanTemp(city.main.temp)))
                        .font(.system(size: 60))
                        .dynamicTypeSize(.xSmall ... .xxLarge)
                    
                    Text(city.weather.first?.main ?? "--")
                        .font(.title)
                        .dynamicTypeSize(.xSmall ... .large)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                    
                    HStack {
                        Text("H:\(mf.string(from: cleanTemp(city.main.tempMax)))")
                        
                        Text("L:\(mf.string(from: cleanTemp(city.main.tempMin)))")
                    }
                    
                    
                    
                }
            }
        }
        .navigationTitle(city.name)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .environment(\.colorScheme, .dark)
    }
    
    func cleanTemp(_ temp: Double) -> Measurement<UnitTemperature> {
        return Measurement<UnitTemperature>(value: temp, unit: .celsius)
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
