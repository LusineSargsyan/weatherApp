//
//  LocalResourceFetcher.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

struct LocalResourceFetcher: LocalResourceFetching {
    let backgroundQueue = DispatchQueue(label: "com.WeatherApp.LocalResourceFetcher")

    func fetch(from localResource: LocalResourced) -> AnyPublisher<Data, GenericError> {
        return Future { promise in
            backgroundQueue.async {
                guard let path = Bundle.main.path(forResource: localResource.name, ofType: localResource.type.rawValue) else {
                    promise(.failure(GenericError.localResourceNotFound))

                    return
                }

                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    promise(.success(data))
                } catch {
                    promise(.failure(GenericError.localResourceNotFound))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
