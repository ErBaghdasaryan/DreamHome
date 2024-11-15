//
//  GeneratorViewController.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 12.11.24.
//

import UIKit
import DreamHomeViewModel
import SnapKit
import Toast

class GeneratorViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let header = UILabel(text: "Passwords example",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let password = UILabel(text: "Paas",
                                 textColor: UIColor(hex: "#00CFA5")!,
                                 font: UIFont(name: "SFProText-Bold", size: 22))
    private let copy = UIButton(type: .system)
    private let passwordLength = SliderView(title: "Password length",
                                            labelNumber: 16,
                                            startNumber: 4,
                                            endNumber: 32)
    private let numberOfPassword = SliderView(title: "Number of password",
                                            labelNumber: 4,
                                            startNumber: 1,
                                            endNumber: 20)
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
    var visualEffectView: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#00242C")

        self.password.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.password.layer.cornerRadius = 10
        self.password.layer.masksToBounds = true

        self.copy.setImage(.init(named: "copyButton"), for: .normal)

        self.generate.setTitle("Generate", for: .normal)
        self.generate.setTitleColor(.white, for: .normal)
        self.generate.backgroundColor = UIColor(hex: "#FF2300")
        self.generate.layer.masksToBounds = true
        self.generate.layer.cornerRadius = 10

        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "#00242C")

        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name("NotificationExample"), object: nil)

        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(header)
        contentView.addSubview(password)
        contentView.addSubview(copy)
        contentView.addSubview(passwordLength)
        contentView.addSubview(numberOfPassword)
        contentView.addSubview(numbers)
        contentView.addSubview(numbers)
        contentView.addSubview(uppercase)
        contentView.addSubview(lowercase)
        contentView.addSubview(spaces)
        contentView.addSubview(specialSymbols)
        contentView.addSubview(generate)
        self.setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.updateExampleLabel()
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
            view.width.equalToSuperview()
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        password.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(72)
            view.height.equalTo(60)
        }

        copy.snp.makeConstraints { view in
            view.centerY.equalTo(password.snp.centerY)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
            view.width.equalTo(48)
        }

        passwordLength.snp.makeConstraints { view in
            view.top.equalTo(password.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(74)
        }

        numberOfPassword.snp.makeConstraints { view in
            view.top.equalTo(passwordLength.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(74)
        }

        numbers.snp.makeConstraints { view in
            view.top.equalTo(numberOfPassword.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        uppercase.snp.makeConstraints { view in
            view.top.equalTo(numbers.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        lowercase.snp.makeConstraints { view in
            view.top.equalTo(uppercase.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        spaces.snp.makeConstraints { view in
            view.top.equalTo(lowercase.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        specialSymbols.snp.makeConstraints { view in
            view.top.equalTo(spaces.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(42)
        }

        generate.snp.makeConstraints { view in
            view.top.equalTo(specialSymbols.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(38)
            view.bottom.equalToSuperview().inset(119)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationExample"), object: nil)
    }
}

//MARK: Make buttons actions
extension GeneratorViewController {
    
    private func makeButtonsAction() {
        copy.addTarget(self, action: #selector(copyText), for: .touchUpInside)
        generate.addTarget(self, action: #selector(addPasswords), for: .touchUpInside)
    }

    @objc func addPasswords() {
        guard let navigationController = self.navigationController else { return }
        guard let lenght = self.passwordLength.lengthLabel.text else { return }
        guard let count = self.numberOfPassword.lengthLabel.text else { return }

        let passwords = generatePasswords(length: Int(lenght) ?? 4,
                                          count: Int(count) ?? 1,
                                          includeDigits: self.numbers.isOn,
                                          includeUppercase: self.uppercase.isOn,
                                          includeLowercase: self.lowercase.isOn,
                                          includeSpaces: self.spaces.isOn,
                                          includeSpecialCharacters: self.specialSymbols.isOn)

        let blurEffect = UIBlurEffect(style: .light)
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView?.frame = self.view.bounds

        guard let visualEffectView = visualEffectView else { return }
        self.view.addSubview(visualEffectView)

        let dimmingView = UIView(frame: self.view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(dimmingView)

        visualEffectView.alpha = 0
        dimmingView.alpha = 0

        UIView.animate(withDuration: 0.1) {
            visualEffectView.alpha = 1
            dimmingView.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            navigationController.navigationBar.isHidden = true
            self.tabBarController?.tabBar.isHidden = true
            _ = AddCollectionView.createAndShow(in: self,
                                                delegate: { [weak self] name in
                guard let self = self else { return }
                self.viewModel?.addCollection(model: .init(name: name,
                                                           passwords: passwords))
                UIView.animate(withDuration: 0, animations: {
                    visualEffectView.alpha = 0
                    dimmingView.alpha = 0
                }) { _ in
                    visualEffectView.removeFromSuperview()
                    dimmingView.removeFromSuperview()
                    navigationController.navigationBar.isHidden = false
                    self.tabBarController?.tabBar.isHidden = false
                }
            }, cancelDelegate: {
                UIView.animate(withDuration: 0, animations: {
                    visualEffectView.alpha = 0
                    dimmingView.alpha = 0
                }) { _ in
                    visualEffectView.removeFromSuperview()
                    dimmingView.removeFromSuperview()
                    navigationController.navigationBar.isHidden = false
                    self.tabBarController?.tabBar.isHidden = false
                }
            })
        }
    }

    @objc func copyText() {
        if let textToCopy = password.text {
            UIPasteboard.general.string = textToCopy

            self.view.makeToast("The text has been copied to the clipboard", duration: 2.0, position: .bottom)
        }
    }

    private func updateExampleLabel() {
        let example = self.generatePasswordExample(length: 16,
                                     includeDigits: self.numbers.isOn,
                                     includeUppercase: self.uppercase.isOn,
                                     includeLowercase: self.lowercase.isOn,
                                     includeSpaces: self.spaces.isOn,
                                     includeSpecialCharacters: self.specialSymbols.isOn)
        self.password.text = example
    }

    @objc func handleNotification(_ notification: Notification) {
        updateExampleLabel()
    }

    func generatePasswords(length: Int, count: Int, includeDigits: Bool, includeUppercase: Bool, includeLowercase: Bool, includeSpaces: Bool, includeSpecialCharacters: Bool) -> [String] {
        if !(includeDigits && includeUppercase && includeLowercase && includeSpaces && includeSpecialCharacters) {
            
        }
        var passwords: [String] = []
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

        for _ in 0..<count {
            var password = ""
            for _ in 0..<length {
                if let randomCharacter = allowedCharacters.randomElement() {
                    password.append(randomCharacter)
                }
            }
            passwords.append(password)
        }

        return passwords
    }

    func generatePasswordExample(length: Int, includeDigits: Bool, includeUppercase: Bool, includeLowercase: Bool, includeSpaces: Bool, includeSpecialCharacters: Bool) -> String {
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
}

extension GeneratorViewController: IViewModelableController {
    typealias ViewModel = IGeneratorViewModel
}

//MARK: Preview
import SwiftUI

struct GeneratorViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let generatorViewController = GeneratorViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<GeneratorViewControllerProvider.ContainerView>) -> GeneratorViewController {
            return generatorViewController
        }

        func updateUIViewController(_ uiViewController: GeneratorViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<GeneratorViewControllerProvider.ContainerView>) {
        }
    }
}
