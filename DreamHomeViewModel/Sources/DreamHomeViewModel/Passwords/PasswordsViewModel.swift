//
//  PasswordsViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import Foundation
import DreamHomeModel

public protocol IPasswordsViewModel {
}

public class PasswordsViewModel: IPasswordsViewModel {

    private let passwordsService: IPasswordsService

    public init(passwordsService: IPasswordsService) {
        self.passwordsService = passwordsService
    }
}
