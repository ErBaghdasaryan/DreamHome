//
//  SettingsAssembly.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import DreamHomeViewModel

final class SettingsAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(ISettingsViewModel.self, initializer: SettingsViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ISettingsService.self, initializer: SettingsService.init)
    }
}
