//
//  MainRoute.swift
//  DreamHomeDesigner
//
//  Created by Er Baghdasaryan on 23.01.25.
//

import Foundation
import UIKit
import DreamHomeViewModel

final class MainRouter: BaseRouter {
    static func showFeatureViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeFeatureViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
