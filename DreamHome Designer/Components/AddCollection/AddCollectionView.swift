//
//  AddCollectionView.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 13.11.24.
//

import UIKit
import SnapKit
import DreamHomeModel

final class AddCollectionView: UIView {

    private var frameView: UIView!
    private let collectionNameField = InputField(title: "Collection", placeholder: "Name")

    private var canceleButton = UIButton(type: .system)
    private var saveButton = UIButton(type: .system)
    private var buttonsStack: UIStackView!
    private var superViewController: UIViewController!

    var delegate: (_ name: String) -> Void = { _ in }
    var cancelDelegate: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeButtonActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        makeButtonActions()
    }

    private func setupUI() {
        backgroundColor = .clear

        frameView = UIView()
        frameView.backgroundColor = .clear

        canceleButton.setTitle("Cancel", for: .normal)
        canceleButton.layer.cornerRadius = 19
        canceleButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        canceleButton.setTitleColor(UIColor.white, for: .normal)
        canceleButton.backgroundColor = .white.withAlphaComponent(0.05)

        saveButton.setTitle("Add", for: .normal)
        saveButton.layer.cornerRadius = 19
        saveButton.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 17)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = UIColor(hex: "#FF2300")

        self.buttonsStack = UIStackView(arrangedSubviews: [canceleButton, saveButton],
                                        axis: .horizontal,
                                        spacing: 8)

        addSubview(frameView)
        frameView.addSubview(collectionNameField)
        frameView.addSubview(buttonsStack)

        setupConstraints()
        setupKeyboardHandling()
    }

    private func setupConstraints() {
        frameView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview()
            view.width.equalTo(390)
            view.height.equalTo(114)
        }

        collectionNameField.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(44)
        }

        buttonsStack.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(38)
        }
    }
}

extension AddCollectionView {
    private func makeButtonActions() {
        canceleButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
    }

    @objc func cancelPressed() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
        } completion: { (_) in
            self.cancelDelegate?()
            self.removeFromSuperview()
        }
    }

    @objc func savePressed() {
        if let name = collectionNameField.customTextField.text {
            disappearAndReturn(model: name)
        } else {
            disappearAndReturn(model: "Password 0")
        }
    }

    private func disappearAndReturn(model: String) {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
        } completion: { (_) in
            self.removeFromSuperview()
            self.delegate(model)
        }
    }

    static func createAndShow(in viewController: UIViewController, delegate: @escaping (_ model: String) -> Void, cancelDelegate: (() -> Void)? = nil) -> AddCollectionView {
        let popup = AddCollectionView(frame: viewController.view.bounds)
        popup.delegate = delegate
        popup.cancelDelegate = cancelDelegate
        popup.superViewController = viewController
        popup.alpha = 0.0
        viewController.view.addSubview(popup)

        UIView.animate(withDuration: 0.3) {
            popup.alpha = 1.0
        }

        return popup
    }
}

//MARK: Setup View tap handlings
extension AddCollectionView {
    private func setupKeyboardHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        self.endEditing(true)
    }
}
