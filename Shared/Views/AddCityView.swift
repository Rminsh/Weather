//
//  AddCityView.swift
//  Weather
//
//  Created by Armin on 7/8/22.
//

import SwiftUI

struct AddCityView: View {
    
    @Binding var cityName: String
    @Binding var loading: Bool
    @Binding var warningMessage: String
    @State var action: () async -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        #if os(iOS)
        NavigationView {
            content
                .navigationTitle("Add City")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Text("Close")
                        }
                    }
                }
        }
        #else
        content
            .frame(width: 320, height: 350)
        #endif
    }
    
    var content: some View {
        VStack(spacing: 15) {
            Text("🏙")
                .font(.system(size: 100))
                .dynamicTypeSize(.xSmall ... .xxLarge)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .padding()
                .opacity(0.75)
            
            Text("Add City")
            
            Label {
                TextField("City name", text: $cityName)
                    .frame(maxWidth: 250)
                    
            } icon: {
                Image(systemName: "magnifyingglass")
            }
            .padding()
            
            if loading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Button(action: {
                    Task.init {
                        action
                    }
                }) {
                    Text("Search & Add")
                        .fontWeight(.semibold)
                }
                #if os(iOS)
                .buttonStyle(.borderedProminent)
                #elseif os(macOS)
                .buttonStyle(.bordered)
                #endif
                .controlSize(.regular)
                .headerProminence(.increased)
            }
            
            Text(warningMessage)
                .foregroundColor(.red)
                .dynamicTypeSize(.xSmall ... .xxLarge)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
        }
        .onDisappear {
            self.loading = false
            self.cityName = ""
            self.warningMessage = ""
        }
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView(
            cityName: .constant(""),
            loading: .constant(false),
            warningMessage: .constant(""),
            action: {}
        )
    }
}
