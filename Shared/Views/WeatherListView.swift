//
//  WeatherListView.swift
//  Shared
//
//  Created by Armin on 7/6/22.
//

import SwiftUI

struct WeatherListView: View {
    
    @StateObject var model: WeatherListViewModel = WeatherListViewModel()
    
    var mf: MeasurementFormatter {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        return mf
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.cities, id: \.id) { city in
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
                            Text(mf.string(from: model.cleanTemp(city.main.temp)))
                                .font(.system(.largeTitle, design: .rounded))
                                .dynamicTypeSize(.xSmall ... .xLarge)
                                .lineLimit(1)
                                .minimumScaleFactor(0.4)
                            
                            HStack {
                                Text("H:\(mf.string(from: model.cleanTemp(city.main.tempMax)))")
                                
                                Text("L:\(mf.string(from: model.cleanTemp(city.main.tempMin)))")
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
            .listStyle(.sidebar)
            .navigationTitle("Weather")
            .task {
                model.loading.toggle()
                await model.getListData()
            }
            .refreshable {
                await model.getListData()
            }
            .overlay {
                ZStack {
                    if model.cities.isEmpty {
                        if model.loading {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                        
                        if let error = model.error {
                            VStack {
                                Text(error)
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                
                                Button(action: {
                                    Task.init {
                                        await model.getListData()
                                    }
                                }) {
                                    Text("Try again")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CityListItem: View {
    
    @Binding var cityDetail: CityDetail
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "cloud.sun.fill")
                .font(.largeTitle)
                .dynamicTypeSize(.xSmall ... .large)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .symbolRenderingMode(.multicolor)
                .shadow(radius: 1)
            
            VStack(alignment: .leading) {
                Text("City")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.medium)
                    .dynamicTypeSize(.xSmall ... .large)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                
                Text("Mostly cloudy")
                    .font(.body)
                    .dynamicTypeSize(.xSmall ... .medium)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("29°")
                    .font(.system(.largeTitle, design: .rounded))
                    .dynamicTypeSize(.xSmall ... .xLarge)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                
                HStack {
                    Text("H:17°")
                    
                    Text("L:15°")
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

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
