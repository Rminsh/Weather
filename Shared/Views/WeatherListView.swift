//
//  WeatherListView.swift
//  Shared
//
//  Created by Armin on 7/6/22.
//

import SwiftUI

struct WeatherListView: View {
    
    @StateObject var model: WeatherListViewModel = WeatherListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.cities, id: \.id) { city in
                    NavigationLink {
                        WeatherDetailView(city: city)
                    } label: {
                        CityListItem(city: city)
                    }
                }
            }
            #if os(macOS)
            .frame(minWidth: 300)
            #endif
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
                                        model.loading = true
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

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
