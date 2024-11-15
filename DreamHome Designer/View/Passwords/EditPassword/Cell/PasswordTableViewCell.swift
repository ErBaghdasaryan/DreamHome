//
//  EditPasswordTableViewCell.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 15.11.24.
//

import UIKit
import SnapKit
import DreamHomeModel
import Combine

class PasswordTableViewCell: UITableViewCell, IReusableView {
    private let content = UIView()

    private let password = UILabel(text: "",
                                   textColor: UIColor.white,
                                   font: UIFont(name: "SFProText-Semibold", size: 17))

    private let passwordCount = UILabel(text: "",
                                        textColor: .white.withAlphaComponent(0.5),
                                        font: UIFont(name: "SFProText-Regular", size: 16))
    private let editButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private var buttonsStack: UIStackView!
    private let botttomView = UIView()

    public var editSubject = PassthroughSubject<Bool, Never>()
    public var deleteSubject = PassthroughSubject<Bool, Never>()
    var cancellables = Set<AnyCancellable>()

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }

    private func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor(hex: "#00242C")

        self.botttomView.backgroundColor = .white.withAlphaComponent(0.05)

        self.editButton.setImage(.init(named: "editPassword"), for: .normal)
        self.deleteButton.setImage(.init(named: "deletePassword"), for: .normal)

        self.password.textAlignment = .left
        self.passwordCount.textAlignment = .left

        self.buttonsStack = UIStackView(arrangedSubviews: [editButton, deleteButton],
                                        axis: .horizontal,
                                        spacing: 8)

        self.contentView.addSubview(content)
        content.addSubview(password)
        content.addSubview(passwordCount)
        content.addSubview(botttomView)
        content.addSubview(buttonsStack)
        setupConstraints()
        makeButtonActions()
    }

    private func setupConstraints() {

        content.snp.makeConstraints { view in
            view.top.equalTo(contentView.snp.top)
            view.leading.equalTo(contentView.snp.leading)
            view.trailing.equalTo(contentView.snp.trailing)
            view.bottom.equalTo(contentView.snp.bottom)
        }

        password.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview().inset(96)
            view.height.equalTo(22)
        }

        passwordCount.snp.makeConstraints { view in
            view.top.equalTo(password.snp.bottom).offset(4)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview().inset(96)
            view.height.equalTo(16)
        }

        botttomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(1)
        }

        buttonsStack.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalTo(passwordCount.snp.trailing).offset(8)
            view.trailing.equalToSuperview()
            view.height.equalTo(40)
        }
    }

    public func setup(with password: String) {
        self.password.text = password
        self.passwordCount.text = "\(password.count) symbols"

        self.setupUI()
    }
}

//MARK: Button actions
extension PasswordTableViewCell {
    private func makeButtonActions() {
        self.editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    @objc func editTapped() {
        self.editSubject.send(true)
    }

    @objc func deleteTapped() {
        self.deleteSubject.send(true)
    }
}
