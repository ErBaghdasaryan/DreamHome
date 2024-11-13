//
//  GeneratorViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import Foundation
import DreamHomeModel

public protocol IGeneratorViewModel {
}

public class GeneratorViewModel: IGeneratorViewModel {

    private let passwordsService: IPasswordsService

    public init(passwordsService: IPasswordsService) {
        self.passwordsService = passwordsService
    }
}
