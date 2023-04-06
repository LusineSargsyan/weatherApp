//
//  URLResponseValidator.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

struct URLResponseValidator: ResponseValidating {
    func validate(routing: Routing, response: (Data, URLResponse)) throws -> Data {
        guard let httpResponse = response.1 as? HTTPURLResponse,
              routing.statusCode.contains(httpResponse.statusCode),
              !response.0.isEmpty else { throw GenericError.responseValidationFailed }

        return response.0
    }
}
