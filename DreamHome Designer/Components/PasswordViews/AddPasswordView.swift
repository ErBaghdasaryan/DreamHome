//
//  AddPasswordView.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 15.11.24.
//

import UIKit
import SnapKit
import DreamHomeModel

final class AddPasswordView: UIView {

    private var frameView: UIView!
    private let passwordField = InputField(title: "Password", placeholder: "Password")
    private let passwordLength = SliderView(title: "Password length",
                                            labelNumber: 16,
                                            startNumber: 4,
                                            endNumber: 32)
    private let numbers = ToggleView(title: "Numbers",
                                     example: "0123456789")
    private let uppercase = ToggleView(title: "Uppercase Latin letters",
                                     example: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    private let lowercase = ToggleView(title: "Lowercase Latin letters",
                                     example: "abcdefghijklmnopqrstuvwxyz")
    private let spaces = ToggleView(title: "Spaces",
                                     example: "")
    private let specialSymbols = ToggleView(title: "Special symbols",
                                            example: "!#$%&()*+./:;=>?@[\\]^`{|}~'\"")
    private let generate = UIButton(type: .system)
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

        generate.setTitle("Generate", for: .normal)
        generate.setTitleColor(.white, for: .normal)
        generate.backgroundColor = UIColor(hex: "#FF2300")
        generate.layer.masksToBounds = true
        generate.layer.cornerRadius = 10

        numbers.toggleSwitch.onTintColor = UIColor(hex: "#FF2300")
        uppercase.toggleSwitch.onTintColor = UIColor(hex: "#FF2300")
        lowercase.toggleSwitch.onTintColor = UIColor(hex: "#FF2300")
        spaces.toggleSwitch.onTintColor = UIColor(hex: "#FF2300")
        specialSymbols.toggleSwitch.onTintColor = UIColor(hex: "#FF2300")

        self.buttonsStack = UIStackView(arrangedSubviews: [canceleButton, saveButton],
                                        axis: .horizontal,
                                        spacing: 8)

        addSubview(frameView)
        frameView.addSubview(passwordField)
        frameView.addSubview(passwordLength)
        frameView.addSubview(numbers)
        frameView.addSubview(numbers)
        frameView.addSubview(uppercase)
        frameView.addSubview(lowercase)
        frameView.addSubview(spaces)
        frameView.addSubview(specialSymbols)
        frameView.addSubview(generate)
        frameView.addSubview(buttonsStack)

        setupConstraints()
        setupKeyboardHandling()
    }

    private func setupConstraints() {
        frameView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview()
            view.width.equalTo(390)
            view.height.equalTo(596)
        }

        passwordField.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(44)
        }

        passwordLength.snp.makeConstraints { view in
            view.top.equalTo(passwordField.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(74)
        }

        numbers.snp.makeConstraints { view in
            view.top.equalTo(passwordLength.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        uppercase.snp.makeConstraints { view in
            view.top.equalTo(numbers.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        lowercase.snp.makeConstraints { view in
            view.top.equalTo(uppercase.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        spaces.snp.makeConstraints { view in
            view.top.equalTo(lowercase.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        specialSymbols.snp.makeConstraints { view in
            view.top.equalTo(spaces.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        generate.snp.makeConstraints { view in
            view.top.equalTo(specialSymbols.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(38)
        }

        buttonsStack.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(38)
        }
    }
}

extension AddPasswordView {
    private func makeButtonActions() {
        canceleButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        generate.addTarget(self, action: #selector(generateTapped), for: .touchUpInside)
    }

    @objc func generateTapped() {
        let length = Int(self.passwordLength.slider.value)
        let password =  self.generatePassword(length: length,
                                              includeDigits: self.numbers.isOn,
                                              includeUppercase: self.uppercase.isOn,
                                              includeLowercase: self.lowercase.isOn,
                                              includeSpaces: self.spaces.isOn,
                                              includeSpecialCharacters: self.specialSymbols.isOn)
        self.passwordField.customTextField.text = password
    }

    private func generatePassword(length: Int, includeDigits: Bool, includeUppercase: Bool, includeLowercase: Bool, includeSpaces: Bool, includeSpecialCharacters: Bool) -> String {

        var password: String = ""
        let digits = "0123456789"
        let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
        let specialCharacters = "!@#$%^&*()_+-=[]{}|;:,.<>?/`~"
        let spaceCharacter = " "

        var allowedCharacters = ""

        if includeDigits {
            allowedCharacters += digits
        }

        if includeUppercase {
            allowedCharacters += uppercaseLetters
        }

        if includeLowercase {
            allowedCharacters += lowercaseLetters
        }

        if includeSpaces {
            allowedCharacters += spaceCharacter
        }

        if includeSpecialCharacters {
            allowedCharacters += specialCharacters
        }

        for _ in 0..<length {
            if let randomCharacter = allowedCharacters.randomElement() {
                password.append(randomCharacter)
            }
        }

        return password

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
        guard let name = passwordField.customTextField.text else { return }
        disappearAndReturn(model: name)
    }

    private func disappearAndReturn(model: String) {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
        } completion: { (_) in
            self.removeFromSuperview()
            self.delegate(model)
        }
    }

    static func createAndShow(in viewController: UIViewController, delegate: @escaping (_ model: String) -> Void, cancelDelegate: (() -> Void)? = nil) -> AddPasswordView {
        let popup = AddPasswordView(frame: viewController.view.bounds)
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
extension AddPasswordView {
    private func setupKeyboardHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        self.endEditing(true)
    }
}
