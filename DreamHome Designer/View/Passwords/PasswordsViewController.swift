//
//  PasswordsViewController.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import UIKit
import DreamHomeViewModel
import SnapKit

class PasswordsViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Passwords list",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#00242C")

        self.view.addSubview(header)
        self.setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    
    }

    private func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(64)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }
    }

}

//MARK: Make buttons actions
extension PasswordsViewController {
    
    private func makeButtonsAction() {
        
    }
}

extension PasswordsViewController: IViewModelableController {
    typealias ViewModel = IPasswordsViewModel
}

//MARK: Preview
import SwiftUI

struct PasswordsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let passwordsViewController = PasswordsViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<PasswordsViewControllerProvider.ContainerView>) -> PasswordsViewController {
            return passwordsViewController
        }

        func updateUIViewController(_ uiViewController: PasswordsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PasswordsViewControllerProvider.ContainerView>) {
        }
    }
}
