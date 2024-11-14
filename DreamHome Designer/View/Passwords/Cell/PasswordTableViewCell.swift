//
//  PasswordTableViewCell.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 14.11.24.
//

import UIKit
import SnapKit
import DreamHomeModel

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

    private func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor(hex: "#00242C")

        self.botttomView.backgroundColor = .white.withAlphaComponent(0.5)

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

    public func setup(with model: PasswordModel) {
        self.password.text = model.name
        self.passwordCount.text = "\(model.passwords.count) passwords"

        self.setupUI()
    }
}
