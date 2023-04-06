//
//  Parsing.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

protocol Parsing {
    func parse<T: Decodable>(from data: Data) throws -> T
}
