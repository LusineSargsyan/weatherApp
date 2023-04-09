//
//  LocalDataBased.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation

protocol LocalDataBased {
    associatedtype T

    func write(object: T) throws
    func read() throws -> [T]
}
