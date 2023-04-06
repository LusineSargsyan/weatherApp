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
    var state: DetailScreenState
    var weather: WeatherResponse? {
        didSet {
            if let weather = weather {
                self.humidity = "\(weather.humidity) %"
                self.temp = "\(weather.temp) °C"
                self.maxTemp = "\(weather.maxTemp) °C"
                self.minTemp = "\(weather.minTemp) °C"
                self.feelsLike = "\(weather.feelsLike) °C"
                self.windSpeed = "\(weather.windSpeed) m/sec"
            }
        }
    }
    var image: UIImage?
    var temp: String = "   "
    var maxTemp: String = "   "
    var minTemp: String = "   "
    var humidity: String = "   "
    var windSpeed: String = "   "
    var feelsLike: String = "   "

    init(state: DetailScreenState) {
        self.state = state
    }
}

struct DetailContentView: View {
    private var viewModel: DetailContentViewModel

    init(viewModel: DetailContentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text(viewModel.temp)
                .padding(.top, 60)
                .redacted(reason: viewModel.state == .loading ? .placeholder : [])

            Text(viewModel.feelsLike)

            if let image = viewModel.image {
                Image(uiImage: image)
            }

            Text(viewModel.state.description)
                .padding(.bottom, 20)
        }
    }
}
