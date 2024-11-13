//
//  TabBarViewController.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import UIKit
import DreamHomeViewModel
import SnapKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        lazy var generatorViewController = self.createNavigation(title: "Generator",
                                                                 image: "generator",
                                                                 vc: ViewControllerFactory.makeGeneratorViewController())

        lazy var passwordsViewController = self.createNavigation(title: "Password list",
                                                                 image: "passwords",
                                                                 vc: ViewControllerFactory.makePasswordsViewController())

        lazy var settingsPageViewController = self.createNavigation(title: "Settings",
                                                                    image: "settings",
                                                                    vc: ViewControllerFactory.makeSettingsViewController())

        self.setViewControllers([generatorViewController, passwordsViewController, settingsPageViewController], animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(setCurrentPageToTeam), name: Notification.Name("ResetCompleted"), object: nil)

        generatorViewController.delegate = self
        passwordsViewController.delegate = self
        settingsPageViewController.delegate = self
    }

    @objc func setCurrentPageToTeam() {
        self.selectedIndex = 0
    }

    private func createNavigation(title: String, image: String, vc: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        self.tabBar.backgroundColor = UIColor(hex: "#0D2F37")
        self.tabBar.barTintColor = UIColor(hex: "#0D2F37")
        tabBar.layer.cornerRadius = 25
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.itemPositioning = .centered

        let unselectedImage = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(named: image)?.withTintColor(.white, renderingMode: .alwaysTemplate)

        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage

        navigation.tabBarItem.title = title

        let nonselectedTitleColor: UIColor = UIColor.white.withAlphaComponent(0.5)
        let selectedTitleColor: UIColor = UIColor.white

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: nonselectedTitleColor
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedTitleColor
        ]

        navigation.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        navigation.tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)

        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)

        return navigation
    }

    // MARK: - Deinit
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        #endif
    }
}

//MARK: Navigation & TabBar Hidden
extension TabBarViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            self.tabBar.isHidden = true
        } else {
            self.tabBar.isHidden = false
        }
    }
}

//MARK: Preview
import SwiftUI

struct TabBarViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let tabBarViewController = TabBarViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) -> TabBarViewController {
            return tabBarViewController
        }

        func updateUIViewController(_ uiViewController: TabBarViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) {
        }
    }
}
