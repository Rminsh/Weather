//
//  CityListItem.swift
//  Weather
//
//  Created by Armin on 7/6/22.
//

import SwiftUI

struct CityListItem: View {
    
    var city: WeatherOfCity
    
    var mf: MeasurementFormatter {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        return mf
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: city.weather.first?.symbolIcon.symbol ?? "exclamationmark.icloud")
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
                Text(mf.string(from: city.main.cleanTemp))
                    .font(.system(.largeTitle, design: .rounded))
                    .dynamicTypeSize(.xSmall ... .xLarge)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                
                HStack {
                    Text("H:\(mf.string(from: city.main.cleanTempMax))")
                    
                    Text("L:\(mf.string(from: city.main.cleanTempMin))")
                }
                .font(.body)
                .dynamicTypeSize(.xSmall ... .small)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .foregroundStyle(.secondary)
            }
        }
    }
}

struct CityListItem_Previews: PreviewProvider {
    static var previews: some View {
        CityListItem(city: WeatherOfCity.mock)
            .padding()
    }
}
