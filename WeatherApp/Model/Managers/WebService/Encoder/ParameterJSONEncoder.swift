//
//  ParameterJSONEncoder.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

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
