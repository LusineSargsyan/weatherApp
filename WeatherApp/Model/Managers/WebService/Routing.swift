//
//  Routing.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

typealias RequestParam = [String: Any]
typealias RequestHeader = [String: String]

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
}

protocol Routing {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var params: RequestParam { get }
    var headers: RequestHeader { get }
    var encoder: ParameterEncoding { get }
    var urlRequest: URLRequest { get }
    var statusCode: Set<Int> { get }
}

extension Routing {
    var headers: RequestHeader { return [:] }
    var httpMethod: HTTPMethod { return .get }
    var encoder: ParameterEncoding { return ParameterURLEncoder() }
    var statusCode: Set<Int> { [200] }
    var params: RequestParam { [:] }

    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org") else {
            preconditionFailure("URL can not be created!")
        }

        return url
    }
    var urlRequest: URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        encoder.encode(params, into: &urlRequest)
        urlRequest.allHTTPHeaderFields = headers

        return urlRequest
    }
}
