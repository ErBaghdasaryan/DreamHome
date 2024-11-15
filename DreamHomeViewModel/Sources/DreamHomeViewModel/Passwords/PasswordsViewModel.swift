//
//  PasswordsViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import Foundation
import DreamHomeModel
import Combine

public protocol IPasswordsViewModel {
    var filteredCollections: [PasswordModel] { get set }
    var collections: [PasswordModel] { get set }
    func filterCollection(with query: String)
    func loadData()
    func addCollection(model: PasswordModel)
    func deleteCollection(by ID: Int)
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
}

public class PasswordsViewModel: IPasswordsViewModel {

    private let passwordsService: IPasswordsService
    public var collections: [PasswordModel] = []
    public var filteredCollections: [PasswordModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(passwordsService: IPasswordsService) {
        self.passwordsService = passwordsService
    }

    public func loadData() {
        do {
            collections = try passwordsService.getCollections()
            filteredCollections = collections
        } catch {
            print(error)
        }
    }

    public func filterCollection(with query: String) {
        if query.isEmpty {
            filteredCollections = collections
        } else {
            filteredCollections = collections.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }

    public func addCollection(model: PasswordModel) {
        do {
            _ = try self.passwordsService.addCollection(model)
        } catch {
            print(error)
        }
    }

    public func deleteCollection(by ID: Int) {
        do {
            try self.passwordsService.deleteCollection(byID: ID)
        } catch {
            print(error)
        }
    }
}
