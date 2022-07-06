//
//  CityListItem.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import SwiftUI

struct CityListItem: View {
    
    @State var city: CityDetail
    
    var mf: MeasurementFormatter {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        return mf
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: WeatherService.getIcon(icon: city.weather.first?.icon ?? "").symbol)
                .font(.largeTitle)
                .dynamicTypeSize(.xSmall ... .large)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .symbolRenderingMode(.multicolor)
                .shadow(radius: 1)
            
            VStack(alignment: .leading) {
                Text(city.name)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.medium)
                    .dynamicTypeSize(.xSmall ... .large)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                
                Text(city.weather.first?.main ?? "")
                    .font(.body)
                    .dynamicTypeSize(.xSmall ... .medium)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(mf.string(from: cleanTemp(city.main.temp)))
                    .font(.system(.largeTitle, design: .rounded))
                    .dynamicTypeSize(.xSmall ... .xLarge)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                
                HStack {
                    Text("H:\(mf.string(from: cleanTemp(city.main.tempMax)))")
                    
                    Text("L:\(mf.string(from: cleanTemp(city.main.tempMin)))")
                }
                .font(.body)
                .dynamicTypeSize(.xSmall ... .small)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .foregroundStyle(.secondary)
            }
        }
    }
    
    func cleanTemp(_ temp: Double) -> Measurement<UnitTemperature> {
        return Measurement<UnitTemperature>(value: temp, unit: .celsius)
    }
}
struct CityListItem_Previews: PreviewProvider {
    static var previews: some View {
        CityListItem(
            city: CityDetail(
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
        )
        .padding()
    }
}
