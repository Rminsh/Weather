//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Armin on 8/22/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: .now,city: .mock)
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        let entry = WeatherEntry(date: .now,city: .mock)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let now = Date()
            let nextUpdate = now.addingTimeInterval(1800) /// 30 minutes
            let service = WeatherService()
            let result = try await service.getWeatherOfCity(city: "Tehran", unit: "metric")
            let entry = WeatherEntry(date: .now, city: result)
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let city: WeatherOfCity
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry

    var mf: MeasurementFormatter {
        let mf = MeasurementFormatter()
        mf.numberFormatter.maximumFractionDigits = 0
        mf.unitOptions = .providedUnit
        return mf
    }
    
    var temp: String {
        entry.city.main.cleanTemp.formatted(
            .measurement(
                width: .narrow,
                usage: .weather,
                numberFormatStyle: .number.precision(.fractionLength(0))
            )
        )
    }
    
    var body: some View {
        HStack {
            tempText
                .contentTransition(.numericText())
            
            detailsView
                .id(entry.city.weather.first?.id)
                .transition(.push(from: .bottom))
        }
        .foregroundStyle(.white)
        .shadow(radius: 4)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    var tempText: some View {
        if #available(iOSApplicationExtension 16.1, *) {
            Text("\(entry.city.main.temp.formatted(.number.precision(.fractionLength(0))))°")
                .font(.largeTitle)
                .fontWeight(.medium)
                .fontDesign(.rounded)
        } else {
            Text("\(entry.city.main.temp.formatted(.number.precision(.fractionLength(0))))°")
                .font(.largeTitle)
                .fontWeight(.medium)
        }
    }
    
    var detailsView: some View {
        VStack {
            Text(entry.city.name)
                .font(.callout)
                .fontWeight(.medium)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(entry.city.weather.first?.main ?? "")
                .font(.caption)
                .fontWeight(.light)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14.0, iOS 17.0, *) {
                WeatherWidgetEntryView(entry: entry)
                    .containerBackground(for: .widget) {
                        Image(entry.city.weather.first?.icon ?? "01d")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
            } else {
                WeatherWidgetEntryView(entry: entry)
                    .padding()
                    .background {
                        Image(entry.city.weather.first?.icon ?? "01d")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now, city: .mock)
    WeatherEntry(date: .now, city: .mock2)
}
