//
//  PasswordsRouter.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import UIKit
import DreamHomeModel

final class PasswordsRouter: BaseRouter {

    static func showEditPasswordViewController(in navigationController: UINavigationController, navigationModel: PasswordNavigationModel) {
        let viewController = ViewControllerFactory.makeEditPasswordViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
