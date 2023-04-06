//
//  LocalDataBased.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import Foundation
import RealmSwift

protocol LocalDataBased {
    associatedtype T

    func write(object: T) throws
    func read() throws -> [T]
}

struct RealmDataBase<T: Object>: LocalDataBased {
    func read() throws -> [T] {
        guard let realm = try? Realm() else {
            // TODO: add new error for realm
            throw GenericError.emptyData
        }

        return Array(realm.objects(T.self))
    }

    func write(object: T) throws {
        guard let realm = try? Realm() else { return }

        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            // TODO: add new error for realm
            throw GenericError.generic(error: error)
        }
    }

    func update<V>(object: T, value: V, keyPath: WritableKeyPath<T, V>) throws {
        guard let realm = try? Realm() else { return }

        var obj = object

        do {
            try realm.write {
                obj[keyPath: keyPath] = value
                realm.add(object, update: .all)
            }
        } catch {
            // TODO: add new error for realm
            throw GenericError.generic(error: error)
        }
    }
}

class LocalDataBaseService<T: LocalDataBased> {
    let dataBase: T

    init(dataBase: T) {
        self.dataBase = dataBase
    }
}

class RealmService<T: Object>: LocalDataBaseService<RealmDataBase<T>> {
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


struct WeatherInputs {
    let service: WeatherWebService
    let realmService: RealmService<WeatherResponse>
}
