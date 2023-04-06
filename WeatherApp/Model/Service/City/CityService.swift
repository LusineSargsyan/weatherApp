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

final class CityListService: LocalResourceService {
    func fetchCities(param: CityParameters) -> AnyPublisher<[City], GenericError> {
        return execute(localResource: param)
    }
}
