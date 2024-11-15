//
//  EditPasswordAssembly.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 15.11.24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import DreamHomeViewModel
import DreamHomeModel

final class EditPasswordAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEditPasswordViewModel.self, argument: PasswordNavigationModel.self, initializer: EditPasswordViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IPasswordsService.self, initializer: PasswordsService.init)
    }
}
