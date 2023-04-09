//
//  CityListTestService.swift
//  WeatherAppTests
//
//  Created by Lusine Sargsyan on 09.04.23.
//

import Foundation
import Combine
import CoreLocation
@testable import WeatherApp

final class CityListTestService: CityListServicing {
    func fetchCities(param: CityParameters) -> AnyPublisher<[City], GenericError> {
        return Future { promise in
            let city = City(id: 616635,
                            name: "Gyumri",
                            country: "AM",
                            coordinates: CLLocationCoordinate2D(latitude: 40.794201,
                                                                longitude: 43.84528))
            promise(.success([city]))
        }
        .eraseToAnyPublisher()
    }
}
