//
//  PasswordsViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import Foundation
import DreamHomeModel

public protocol IPasswordsViewModel {
    var filteredCollections: [PasswordModel] { get set }
    var collections: [PasswordModel] { get set }
    func filterCollection(with query: String)
    func loadData()
}

public class PasswordsViewModel: IPasswordsViewModel {

    private let passwordsService: IPasswordsService
    public var collections: [PasswordModel] = []
    public var filteredCollections: [PasswordModel] = []

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
}
