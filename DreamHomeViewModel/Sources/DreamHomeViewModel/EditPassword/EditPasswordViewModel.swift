//
//  EditPasswordViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 15.11.24.
//

import Foundation
import DreamHomeModel
import Combine

public protocol IEditPasswordViewModel {
    var collection: PasswordModel { get set }
    func editCollection(model: PasswordModel)
}

public class EditPasswordViewModel: IEditPasswordViewModel {

    private let passwordsService: IPasswordsService
    public var collection: PasswordModel
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(passwordsService: IPasswordsService, navigationModel: PasswordNavigationModel) {
        self.passwordsService = passwordsService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.collection = navigationModel.model
    }

    public func editCollection(model: PasswordModel) {
        do {
            try self.passwordsService.editCollection(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
