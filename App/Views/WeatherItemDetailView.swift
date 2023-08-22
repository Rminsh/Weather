//
//  WeatherItemDetailView.swift
//  Weather
//
//  Created by Armin on 7/7/22.
//

import SwiftUI

struct WeatherItemDetailView: View {
    
    var icon: String
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.secondary)
                .frame(width: 28)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(value)
                    .font(.title2)
                    .dynamicTypeSize(.xSmall ... .large)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
            }
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .mask {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
        }
    }
}

struct WeatherItemDetailView_Previews: PreviewProvider {
    
    static let layout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    static var previews: some View {
        ZStack {
            Color.cyan.edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(0...10, id: \.self) { _ in
                        WeatherItemDetailView(
                            icon: "command",
                            title: "Test",
                            value: "Test"
                        )
                        WeatherItemDetailView(
                            icon: "command",
                            title: "Test",
                            value: "Test"
                        )
                    }
                }
                .padding()
            }
        }
    }
}
