//
//  WeatherMainInfoViewModel.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 09.04.23.
//

import UIKit

struct WeatherMainInfoViewModel {
    let updatedDate: String
    let description: String
    let tempreture: String
    let feelsLike: String
    let image: UIImage?

    init(updatedDate: String,
         description: String,
         tempreture: String,
         feelsLike: String,
         image: UIImage?) {
        self.updatedDate = "Updated at \(updatedDate)"
        self.image = image
        self.description = description
        self.tempreture = tempreture
        self.feelsLike = feelsLike
    }
}
