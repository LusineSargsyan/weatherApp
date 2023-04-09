//
//  ParameterJSONEncoder.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

/// Encoder to encode params to data and set to httpBody of urlRequest
/// It is not used in the project but written for vision how it can be implemented for POST, PUT requests
/// Usage in web service parameters `var encoder: ParameterEncoding { ParameterJSONEncoder() }`
struct ParameterJSONEncoder: ParameterEncoding {
    func encode(_ parameters: RequestParam, into urlRequest: inout URLRequest) {
        guard !parameters.isEmpty else { return }

        do {
            let data = try JSONSerialization.data(withJSONObject: parameters,
                                                  options: .prettyPrinted)
            urlRequest.httpBody = data
        } catch {
            print(error.localizedDescription)
        }
    }
}
