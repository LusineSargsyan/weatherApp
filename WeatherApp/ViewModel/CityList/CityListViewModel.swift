//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation
import Combine

struct CityListInputs {
    let service: CityListService

    init(service: CityListService) {
        self.service = service
    }
}

final class CityListViewModel: ViewModel<CityListInputs> {
    @Published var cityNames: [String] = []

    func getCityList() {
        execute(service: inputs.service.fetchCities(param: CityParameters())) { [weak self] cities in
            self?.cityNames = cities.map { $0.name }
        }
    }
}
