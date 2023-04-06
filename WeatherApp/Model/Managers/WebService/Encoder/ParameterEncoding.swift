//
//  Encoder.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

protocol ParameterEncoding {
    func encode(_ parameters: RequestParam, into urlRequest: inout URLRequest)
}
