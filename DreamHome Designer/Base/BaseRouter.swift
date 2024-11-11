//
//  BaseRouter.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import UIKit
import Combine
import DreamHomeViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
