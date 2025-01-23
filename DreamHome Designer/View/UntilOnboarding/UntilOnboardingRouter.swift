//
//  UntilOnboardingRouter.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import UIKit
import DreamHomeModel

final class UntilOnboardingRouter: BaseRouter {

    static func showTabBarViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTabBarViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showOnboardingViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeOnboardingViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showMainViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeMainViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showFeatureViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeFeatureViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
