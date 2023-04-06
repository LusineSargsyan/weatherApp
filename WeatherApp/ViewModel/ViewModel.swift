//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 05.04.23.
//

import Foundation
import Combine

struct AlertItem {
    let title: String
    let message: String
    let buttonTitle: String
}

class ViewModel<T>: ViewModeling, ObservableObject {
    @Published var isLoading: Bool = false
    @Published var alertItem: AlertItem? = nil

    var subscriptions = Set<AnyCancellable>()

    let inputs: T

    init(inputs: T) {
        self.inputs = inputs
    }

    func execute<T: Decodable>(service: AnyPublisher<T, GenericError>,
                 complition: @escaping (T) -> Void) {
        handleLoading(flag: true)

        service.receive(on: DispatchQueue.main)
            .sink { [weak self] c in
                self?.handleLoading(flag: false)
                
                if case let .failure(error) = c {
                    self?.handleError(error: error)
                }
            } receiveValue: { value in
                complition(value)
            }
            .store(in: &subscriptions)
    }

    func handleError(error: GenericError) {
        alertItem = AlertItem(title: "Oups!", message: "Something went wrong", buttonTitle: "Ok")
    }

    func handleLoading(flag: Bool) {
        self.isLoading = flag
    }
}
