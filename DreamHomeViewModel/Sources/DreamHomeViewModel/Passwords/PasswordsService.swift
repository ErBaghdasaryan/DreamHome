//
//  PasswordsService.swift
//  
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import UIKit
import DreamHomeModel
import SQLite

public protocol IPasswordsService {
    func addCollection(_ model: PasswordModel) throws -> PasswordModel
    func getCollections() throws -> [PasswordModel]
    func editCollection(_ model: PasswordModel) throws
    func deleteCollection(byID id: Int) throws
}

public class PasswordsService: IPasswordsService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    typealias Expression = SQLite.Expression

    public init() { }

    public func addCollection(_ model: PasswordModel) throws -> PasswordModel {
        let db = try Connection("\(path)/db.sqlite3")
        let passwordsTable = Table("Passwords")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let passwordsColumn = Expression<String>("passwords")

        try db.run(passwordsTable.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(nameColumn)
            t.column(passwordsColumn)
        })

        let passwordsString = model.passwords.joined(separator: ",")

        let rowId = try db.run(passwordsTable.insert(
            nameColumn <- model.name,
            passwordsColumn <- passwordsString
        ))

        return PasswordModel(id: Int(rowId), name: model.name, passwords: model.passwords)
    }

    public func getCollections() throws -> [PasswordModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let passwordsTable = Table("Passwords")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let passwordsColumn = Expression<String>("passwords")

        var result: [PasswordModel] = []

        for row in try db.prepare(passwordsTable) {
            let passwordsArray = row[passwordsColumn].components(separatedBy: ",")

            let passwordModel = PasswordModel(id: row[idColumn],
                                              name: row[nameColumn],
                                              passwords: passwordsArray)
            result.append(passwordModel)
        }

        return result
    }

    public func editCollection(_ model: PasswordModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let passwordsTable = Table("Passwords")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let passwordsColumn = Expression<String>("passwords")

        guard let id = model.id else {
            throw NSError(domain: "PasswordService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid model ID"])
        }

        let passwordsString = model.passwords.joined(separator: ",")

        let passwordToUpdate = passwordsTable.filter(idColumn == id)
        try db.run(passwordToUpdate.update(
            nameColumn <- model.name,
            passwordsColumn <- passwordsString
        ))
    }

    public func deleteCollection(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let passwordsTable = Table("Passwords")
        let idColumn = Expression<Int>("id")

        let passwordToDelete = passwordsTable.filter(idColumn == id)
        try db.run(passwordToDelete.delete())
    }

}
