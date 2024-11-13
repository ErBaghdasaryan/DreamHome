//
//  AddCollectionView.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 13.11.24.
//

import UIKit
import SnapKit

final class AddCollectionView: UIView {

    private var frameView: UIView!
    private var titleLabel = UILabel(text: "Congratulation!",
                                     textColor: UIColor.black,
                                     font: UIFont(name: "SFProText-Bold", size: 28))
    private var messageLabel = UILabel(text: "You are one step closer to your well-being again!",
                                      textColor: UIColor.black,
                                      font: UIFont(name: "SFProText-Regular", size: 17))
    private var superViewController: UIViewController!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupActions()
    }

    private func setupUI() {
        backgroundColor = .clear

        frameView = UIView()
        frameView.layer.cornerRadius = 15
        frameView.layer.masksToBounds = true
        frameView.backgroundColor = .clear

        self.messageLabel.numberOfLines = 2

        addSubview(frameView)
        frameView.addSubview(titleLabel)
        frameView.addSubview(messageLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        frameView.snp.makeConstraints { view in
            view.center.equalToSuperview()
            view.width.equalTo(358)
            view.height.equalTo(214)
        }

        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(32)
            view.leading.trailing.equalToSuperview().inset(32)
            view.height.equalTo(34)
        }

        messageLabel.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(16)
            view.leading.trailing.equalToSuperview().inset(32)
            view.height.equalTo(44)
        }

    }

    private func setupActions() {
//        dairyButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
//        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }

    @objc private func dismissView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }

    static func show(in viewController: UIViewController) -> AddCollectionView {
        let popup = AddCollectionView(frame: viewController.view.bounds)
        popup.superViewController = viewController
        popup.alpha = 0.0
        viewController.view.addSubview(popup)

        UIView.animate(withDuration: 0.3) {
            popup.alpha = 1.0
        }

        return popup
    }
}
