//
//  JSONDecoderParser.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation

struct JSONDecoderParser: Parsing {
    func parse<T>(from data: Data) throws -> T where T : Decodable {
        do {
            let parsedData = try JSONDecoder().decode(T.self, from: data)

            return parsedData
        }
    }
}
