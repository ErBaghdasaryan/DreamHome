//
//  GeneratorAssembly.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import DreamHomeViewModel

final class GeneratorAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IGeneratorViewModel.self, initializer: GeneratorViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IPasswordsService.self, initializer: PasswordsService.init)
    }
}
