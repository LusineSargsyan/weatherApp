//
//  RealmService.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 09.04.23.
//

import Foundation
import RealmSwift

final class RealmService<T: Object>: LocalDataBaseService<RealmDataBase<T>> {
    func read() throws -> [T] {
        return try dataBase.read()
    }

    func write(object: T) throws {
        try dataBase.write(object: object)
    }

    func update<V>(object: T, value: V, keyPath: WritableKeyPath<T, V>) throws {
        try dataBase.update(object: object, value: value, keyPath: keyPath)
    }
}
