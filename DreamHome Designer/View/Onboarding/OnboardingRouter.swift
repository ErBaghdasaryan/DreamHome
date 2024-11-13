//
//  OnboardingROuter.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import Foundation
import UIKit
import DreamHomeViewModel

final class OnboardingRouter: BaseRouter {
    static func showTabBarViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTabBarViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
