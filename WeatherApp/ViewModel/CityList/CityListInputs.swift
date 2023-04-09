//
//  CityListInputs.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 09.04.23.
//

import Foundation

struct CityListInputs {
    let service: CityListService

    init(service: CityListService) {
        self.service = service
    }
}
