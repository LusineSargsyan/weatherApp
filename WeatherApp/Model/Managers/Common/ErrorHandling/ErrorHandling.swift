//
//  ErrorHandling.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

protocol ErrorHandling {
    func handleError(error: Error) -> GenericError
}
