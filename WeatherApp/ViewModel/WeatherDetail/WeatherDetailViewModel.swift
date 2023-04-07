//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import UIKit
import Combine
import Reachability
import SwiftUI

enum DetailScreenState {
    case empty
    case dataFromLocalStorage
    case dataFromNetwork
    case loading
}

struct WeatherDetailInputs {
    let service: WeatherWebService
    let weatherRealmService: RealmService<WeatherResponse>
    let downloadService: DownloadService

    init(service: WeatherWebService,
         weatherRealmService: RealmService<WeatherResponse>,
         downloadService: DownloadService) {
        self.service = service
        self.weatherRealmService = weatherRealmService
        self.downloadService = downloadService
    }
}

final class WeatherDetailViewModel: ViewModel<WeatherDetailInputs> {
    private let cityName: String
    @AppStorage("CurrentDate", store: .standard) var currentDate = ""

    @Published var state: DetailScreenState? {
        didSet {
            if let state {
                detailModel.state = state
            }
        }
    }
    @Published var detailModel: DetailContentViewModel = DetailContentViewModel(state: .empty)

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

    private func dowloadImage(with iconName: String, complition: @escaping (Data) -> Void) {
        inputs.downloadService.download(routing: WeatherIconParameter(iconName: iconName))
            .receive(on: DispatchQueue.main)
            .sink { c in
                // TODO:
            } receiveValue: { data in
                complition(data)
            }
            .store(in: &subscriptions)

    }

    func getWeatherDetails() {
        if try! Reachability().connection == .unavailable {
            do {
                guard let weatherDetail = try inputs.weatherRealmService.read().first(where: { $0.name == cityName }) else {
                    state = .empty

                    return
                }

                state = .dataFromLocalStorage
                detailModel.weather = weatherDetail

                if let data = weatherDetail.iconData {
                    detailModel.image = UIImage(data: data)
                }
            } catch {
                print(GenericError.realmReadFailed)
            }
        } else {
            execute(service: inputs.service.fetchweather(param: WeatherParameter(city: cityName))) { [weak self] weather in
                self?.state = .dataFromNetwork

                do {
                    try self?.inputs.weatherRealmService.write(object: weather)
                } catch {
                    print(GenericError.realmWriteFailed)
                }
                self?.updateCurrentDate()
                self?.detailModel.weather = weather
                self?.dowloadImage(with: weather.weather?.icon ?? "") { data in
                    self?.detailModel.image = UIImage(data: data)

                    do {
                        try self?.inputs.weatherRealmService.update(object: weather, value: data, keyPath: \.iconData)
                    } catch {
                        print(GenericError.realmUpdateFailed)
                    }
                }
            }
        }
    }

    func updateCurrentDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        let currentUpdateDate = dateFormatter.string(from: date)

        currentDate = currentUpdateDate
    }
}
