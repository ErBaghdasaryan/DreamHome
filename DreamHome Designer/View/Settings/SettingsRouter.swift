//
//  SettingsRouter.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import Foundation
import UIKit
import DreamHomeViewModel

final class SettingsRouter: BaseRouter {
    static func showUsageViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeUsageViewController()
        navigationController.navigationBar.isHidden = false
        navigationController.navigationItem.hidesBackButton = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
