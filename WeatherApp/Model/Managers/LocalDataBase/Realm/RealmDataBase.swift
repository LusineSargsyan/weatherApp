//
//  RealmDataBase.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 09.04.23.
//

import Foundation
import RealmSwift

struct RealmDataBase<T: Object>: LocalDataBased {
    static func start() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, _ in }
        )

        Realm.Configuration.defaultConfiguration = config
    }

    private let configuration: Realm.Configuration

    init(configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }

    func read() throws -> [T] {
        guard let realm = try? Realm(configuration: configuration) else {
            throw GenericError.realmReadFailed
        }

        return Array(realm.objects(T.self))
    }

    func write(object: T) throws {
        guard let realm = try? Realm(configuration: configuration) else { return }

        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            throw GenericError.realmWriteFailed
        }
    }

    func update<V>(object: T, value: V, keyPath: WritableKeyPath<T, V>) throws {
        guard let realm = try? Realm(configuration: configuration) else { return }

        var obj = object

        do {
            try realm.write {
                obj[keyPath: keyPath] = value
                realm.add(object, update: .all)
            }
        } catch {
            throw GenericError.realmUpdateFailed
        }
    }
}
