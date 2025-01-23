//
//  ServiceAssembly.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import DreamHomeViewModel

public final class ServiceAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        container.autoregister(IKeychainService.self, initializer: KeychainService.init)
        container.autoregister(IAppStorageService.self, initializer: AppStorageService.init)
        container.autoregister(IValidationService.self, initializer: ValidationService.init)
    }
}

