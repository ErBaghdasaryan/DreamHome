//
//  InputField.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 15.11.24.
//

import UIKit

class InputField: UIView {

    private let titleLabel = UILabel(text: "",
                                     textColor: .white,
                                     font: UIFont(name: "SFProText-Regular", size: 17))

    public var customTextField: CustomTextField!

    public var bottomView = UIView()

    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        customTextField = CustomTextField(placeholder: placeholder)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {

        self.backgroundColor = .clear

        titleLabel.textAlignment = .left
        bottomView.backgroundColor = .gray

        addSubview(titleLabel)
        addSubview(customTextField)
        addSubview(bottomView)
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(11)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(100)
            view.height.equalTo(22)
        }

        customTextField.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(11)
            view.leading.equalTo(titleLabel.snp.trailing)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        bottomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(1)
        }
    }
}
