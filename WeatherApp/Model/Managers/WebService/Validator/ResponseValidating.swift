//
//  ResponseValidating.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

protocol ResponseValidating {
    func validate(routing: Routing, response: (Data, URLResponse)) throws -> Data
}
