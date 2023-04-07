//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject private var viewModel: WeatherDetailViewModel

    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .some(.empty):
                EmptyDetailView()
            case .some(.dataFromNetwork), .some(.dataFromLocalStorage), .some(.loading):
                DetailContentView(viewModel: viewModel.detailModel)
            default:
                EmptyView()
            }
        }
        .navigationTitle(viewModel.detailModel.weather?.name ?? "")
        .alert(item: $viewModel.alertItem)
        .onAppear {
            viewModel.getWeatherDetails()
        }
    }
}

extension View {
    func alert(item: Binding<AlertItem?>) -> some View {
        let isPresented = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )

        return alert(isPresented: isPresented) {
            Alert(title: Text(item.wrappedValue?.title ?? "Oups"),
                  message: Text(item.wrappedValue?.message ?? ""),
                  dismissButton: .default(Text(item.wrappedValue?.buttonTitle ?? "OK"))
            )
        }
    }
}

struct DetailContentViewModel {
    @AppStorage("CurrentDate", store: .standard) var currentDate = ""

    var state: DetailScreenState
    var image: UIImage?
    var description: String = "   "
    var temp: String = "   "
    var maxTemp: String = "   "
    var minTemp: String = "   "
    var humidity: String = "   "
    var windSpeed: String = "   "
    var feelsLike: String = "   "
    var weather: WeatherResponse? {
        didSet {
            if let weather = weather {
                if let desc = weather.weather?.desc {
                    self.description = desc.capitalized
                }
                self.humidity = "\(weather.humidity) %"
                self.temp = "\(weather.temp) °C"
                self.maxTemp = "\(weather.maxTemp) °C"
                self.minTemp = "\(weather.minTemp) °C"
                self.feelsLike = "\(weather.feelsLike) °C"
                self.windSpeed = "\(weather.windSpeed) m/s"
            }
        }
    }

    init(state: DetailScreenState) {
        self.state = state
    }
}

struct MoreInfoViewModel {
    let minTemp: String
    let maxTemp: String
    let humidity: String
    let windSpeed: String
}

struct InfoViewModel {
    let title: String
    let desc: String
}
