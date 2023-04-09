//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Combine
import Reachability
import SwiftUI

final class WeatherDetailViewModel: ViewModel<WeatherDetailInputs> {
    @AppStorage("UpdatedDate", store: .standard) var updatedDate = ""
    @Published var state: WeatherDetailScreenState? {
        didSet {
            if let state {
                detailModel.state = state
            }
        }
    }
    @Published var detailModel: WeatherDetailContentViewModel = WeatherDetailContentViewModel(state: .empty)

    let cityName: String

    init(cityName: String,
         inputs: WeatherDetailInputs) {
        self.cityName = cityName

        super.init(inputs: inputs)
    }

    override func handleLoading(flag: Bool) {
        if flag {
            state = .loading
        }
    }

    func getWeatherDetails() {
        if inputs.reachibility?.connection == .unavailable {
            do {
                try readFromRealm()
            } catch {
                self.handleError(error: GenericError.realmReadFailed)
            }
        } else {
            executeFromNetwork()
        }
    }

    // MARK: - Private API
    private func readFromRealm() throws {
        guard let weatherDetail = try inputs.weatherRealmService.read().first(where: { $0.name == cityName }) else {
            state = .empty

            return
        }

        state = .success(weather: weatherDetail)

        if let data = weatherDetail.iconData {
            detailModel.image = UIImage(data: data)
        }
    }

    private func dowloadImage(with iconName: String, complition: @escaping (Data) -> Void) {
        inputs.downloadService.download(routing: WeatherIconParameter(iconName: iconName))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                if case .failure = value {
                    self?.detailModel.image = UIImage(named: "placeholder")
                }
            } receiveValue: { data in
                complition(data)
            }
            .store(in: &subscriptions)
    }

    private func executeFromNetwork() {
        execute(service: inputs.service.fetchWeather(param: WeatherParameter(city: cityName))) { [weak self] weather in
            self?.state = .success(weather: weather)

            do {
                try self?.inputs.weatherRealmService.write(object: weather)
            } catch {
                self?.handleError(error: GenericError.realmWriteFailed)
            }

            self?.updateCurrentDate()
            self?.dowloadImage(with: weather.weather?.icon ?? "") { data in
                self?.detailModel.image = UIImage(data: data)

                do {
                    try self?.inputs.weatherRealmService.update(object: weather, value: data, keyPath: \.iconData)
                } catch {
                    self?.handleError(error: GenericError.realmUpdateFailed)
                }
            }
        }
    }

    private func updateCurrentDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        let currentUpdateDate = dateFormatter.string(from: date)

        updatedDate = currentUpdateDate
    }
}
