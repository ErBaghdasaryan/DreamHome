//
//  ViewControllerFactory.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import Foundation
import Swinject
import DreamHomeViewModel
import DreamHomeModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]

    //MARK: - UntilOnboarding
    static func makeUntilOnboardingViewController() -> UntilOnboardingViewController {
        let assembler = Assembler(commonAssemblies + [UntilOnboardingAssembly()])
        let viewController = UntilOnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IUntilOnboardingViewModel.self)
        return viewController
    }

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: - TabBar
    static func makeTabBarViewController() -> TabBarViewController {
        let viewController = TabBarViewController()
        return viewController
    }

    //MARK: Generator
    static func makeGeneratorViewController() -> GeneratorViewController {
        let assembler = Assembler(commonAssemblies + [GeneratorAssembly()])
        let viewController = GeneratorViewController()
        viewController.viewModel = assembler.resolver.resolve(IGeneratorViewModel.self)
        return viewController
    }

    //MARK: Passwords
    static func makePasswordsViewController() -> PasswordsViewController {
        let assembler = Assembler(commonAssemblies + [PasswordAssembly()])
        let viewController = PasswordsViewController()
        viewController.viewModel = assembler.resolver.resolve(IPasswordsViewModel.self)
        return viewController
    }

    static func makeEditPasswordViewController(navigationModel: PasswordNavigationModel) -> EditPasswordViewController {
        let assembler = Assembler(commonAssemblies + [EditPasswordAssembly()])
        let viewController = EditPasswordViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditPasswordViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    static func makeUsageViewController() -> UsageViewController {
        let viewController = UsageViewController()
        return viewController
    }
}
