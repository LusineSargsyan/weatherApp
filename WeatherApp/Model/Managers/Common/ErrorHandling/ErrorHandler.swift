//
//  ErrorHandler.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

struct ErrorHandler: ErrorHandling {
    func handleError(error: Error) -> GenericError {
        switch error {
        case let e as URLError:
            return GenericError.requestFailed(error: e)
        case let e as DecodingError:
            return GenericError.parsingFailed(error: e)
        case let e as GenericError:
            return e
        default:
            return GenericError.generic(error: error)
        }
    }
}
