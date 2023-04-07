//
//  GenericError.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

enum GenericError: Error, CustomDebugStringConvertible {
    case generic(error: Error)
    case responseValidationFailed
    case parsingFailed(error: Error)
    case requestFailed(error: Error)
    case localResourceNotFound
    case emptyData
    case realmWriteFailed
    case realmReadFailed
    case realmUpdateFailed

    var debugDescription: String {
        switch self {
        case .generic(let error):
            return "Generic error \(error.localizedDescription)"
        case .responseValidationFailed:
            return "Response validation failed with error"
        case .parsingFailed(let error):
            return "Parsing failed with error \(error.localizedDescription)"
        case .requestFailed(let error):
            return "Request failed with error \(error.localizedDescription)"
        case .localResourceNotFound:
            return "Local resource not founded"
        case .emptyData:
            return "Data is empty"
        case .realmWriteFailed:
            return "Write failed"
        case .realmReadFailed:
            return "Read failed"
        case .realmUpdateFailed:
            return "Update failed"
        }
    }
}
