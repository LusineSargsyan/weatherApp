//
//  ManagerProvider.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import Foundation

enum ManagerProvider {
    static func localResourceDataFetcher(localResourceFetcher: LocalResourceFetching = LocalResourceFetcher(),
                                         parser: Parsing = JSONDecoderParser(),
                                         responseValidator: LocalResourceValidating = LocalResourceValidator(),
                                         errorHandler: ErrorHandling = ErrorHandler()) -> LocalResourceDataFetching {
        return LocalResourceDataFetcher(localResourceFetcher: localResourceFetcher,
                                        parser: parser,
                                        responseValidator: responseValidator,
                                        errorHandler: errorHandler)
    }

    static func networkDataFetcher(networkManager: Networking = NetworkManager(),
                                   parser: Parsing = JSONDecoderParser(),
                                   responseValidator: ResponseValidating = URLResponseValidator(),
                                   errorHandler: ErrorHandling = ErrorHandler()) -> NetworkDataFetching {
        return NetworkDataFetcher(networkManager: networkManager,
                                  parser: parser,
                                  responseValidator: responseValidator,
                                  errorHandler: errorHandler)
    }
}
