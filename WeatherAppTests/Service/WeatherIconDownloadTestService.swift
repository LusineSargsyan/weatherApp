//
//  WeatherIconDownloadTestService.swift
//  WeatherAppTests
//
//  Created by Lusine Sargsyan on 10.04.23.
//

import UIKit
import Combine
@testable import WeatherApp

struct WeatherIconDownloadTestService: WeatherIconDownloadServicing {
    func downloadWeatherIcon(routing: WeatherIconParameter) -> AnyPublisher<Data, GenericError> {
        return Future { promise in
            let image = UIImage(named: "sad_cloud")
            guard let data = image?.pngData() else {
                promise(.failure(GenericError.emptyData))
                return
            }

            promise(.success(data))
        }
        .eraseToAnyPublisher()
    }
}
