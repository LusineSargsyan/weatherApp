//
//  ParameterURLEncoder.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

/// Encoder to encode params in urlRequest's path
/// Usage in web service parameters `var encoder: ParameterEncoding { ParameterJSONEncoder() }`
struct ParameterURLEncoder: ParameterEncoding {
    func encode(_ parameters: RequestParam, into urlRequest: inout URLRequest) {
        guard !parameters.isEmpty,
              var urlComponents = URLComponents(string: urlRequest.url?.absoluteString ?? "") else { return }

        let queryItems = parameters.map {
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }

        urlComponents.queryItems = queryItems
        urlRequest.url = urlComponents.url
    }
}
