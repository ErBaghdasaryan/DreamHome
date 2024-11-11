//
//  BaseViewController.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import UIKit
import Combine
import DreamHomeViewModel

public protocol IViewModelableController {
    associatedtype ViewModel

    var viewModel: ViewModel? { get }
}

class BaseViewController: UIViewController {
    var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModel()
        NotificationCenter.default.addObserver(self, selector: #selector(resetProgress), name: Notification.Name("ResetCompleted"), object: nil)
    }

    func setupUI() {

    }

    func setupViewModel() {
        
    }

    @objc func resetProgress() {
        
    }

    func addSwipeToBack() {
        let swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(popAfterSwipeLeft))
        swipeToRight.direction = .right
        self.view.addGestureRecognizer(swipeToRight)
    }

    @objc private func popAfterSwipeLeft() {
//        TabBarRouter.popViewController(in: navigationController)
    }

    // MARK: - Deinit
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        NotificationCenter.default.removeObserver(self)
        #endif
    }
}
