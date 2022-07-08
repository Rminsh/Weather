//
//  WeatherListView.swift
//  Shared
//
//  Created by Armin on 7/6/22.
//

import SwiftUI

struct WeatherListView: View {
    
    @StateObject var model: WeatherListViewModel = WeatherListViewModel()
    
    @AppStorage("iconStyle") var iconStyle: Bool = true
    @State private var searchText = ""
    
    var searchResults: [CityDetail] {
        if searchText.isEmpty {
            return model.cities
        } else {
            return model.cities.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.id) { city in
                    NavigationLink {
                        WeatherDetailView(city: city)
                    } label: {
                        CityListItem(city: city)
                    }
                }
                .onDelete {
                    model.cities.remove(atOffsets: $0)
                    model.savedCities.remove(atOffsets: $0)
                }
                .onMove {
                    model.cities.move(fromOffsets: $0, toOffset: $1)
                    model.savedCities.move(fromOffsets: $0, toOffset: $1)
                }
            }
            #if os(macOS)
            .frame(minWidth: 300)
            #endif
            .listStyle(.sidebar)
            .navigationTitle("Weather")
            .searchable(text: $searchText, placement: .sidebar)
            .popover(isPresented: $model.showAddCityView) {
                AddCityView(
                    cityName: $model.addCityName,
                    loading: $model.addLoading,
                    warningMessage: $model.addError
                ) {
                    Task.init {
                        await model.addCity()
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {model.showAddCityView = true}) {
                        Label("Add city", systemImage: "plus")
                    }
                }
                #if os(iOS)
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                #endif
                ToolbarItem {
                    Menu {
                        Toggle(isOn: $iconStyle) {
                            Label("Icon Style", systemImage: "sparkles")
                        }
                    } label: {
                        Label("Options", systemImage: "ellipsis.circle")
                            .labelStyle(.iconOnly)
                    }
                }
            }
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
            
            Text("Select a city")
        }
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
