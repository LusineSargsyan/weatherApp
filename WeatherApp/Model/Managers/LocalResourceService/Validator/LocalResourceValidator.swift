//
//  LocalResourceValidator.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

struct LocalResourceValidator: LocalResourceValidating {
    func validate(data: Data) throws {
        guard !data.isEmpty else {
            throw GenericError.emptyData
        }
    }
}
