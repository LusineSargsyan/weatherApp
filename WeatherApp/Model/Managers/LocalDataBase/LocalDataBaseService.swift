//
//  LocalDataBaseService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 09.04.23.
//

import Foundation

class LocalDataBaseService<T: LocalDataBased> {
    let dataBase: T

    init(dataBase: T) {
        self.dataBase = dataBase
    }
}
