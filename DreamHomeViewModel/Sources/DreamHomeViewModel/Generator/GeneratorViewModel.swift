//
//  GeneratorViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import Foundation
import DreamHomeModel

public protocol IGeneratorViewModel {
    func addCollection(model: PasswordModel)
}

public class GeneratorViewModel: IGeneratorViewModel {

    private let passwordsService: IPasswordsService

    public init(passwordsService: IPasswordsService) {
        self.passwordsService = passwordsService
    }

    public func addCollection(model: PasswordModel) {
        do {
            _ = try self.passwordsService.addCollection(model)
        } catch {
            print(error)
        }
    }
}
