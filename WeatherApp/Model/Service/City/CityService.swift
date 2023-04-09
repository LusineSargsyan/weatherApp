//
//  CityService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation
import Combine

struct CityParameters: LocalResourced {
    var name: String { return "city.list" }
}

protocol CityListServicing {
    func fetchCities(param: CityParameters) -> AnyPublisher<[City], GenericError>
}

final class CityListService: LocalResourceService, CityListServicing {
    func fetchCities(param: CityParameters) -> AnyPublisher<[City], GenericError> {
        return execute(localResource: param)
    }
}
