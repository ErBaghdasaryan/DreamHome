//
//  ToggleView.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 13.11.24.
//

import UIKit

class ToggleView: UIView {

    private let titleLabel = UILabel(text: "",
                                     textColor: .white,
                                     font: UIFont(name: "SFProText-Semibold", size: 17))

    private let exampleLabel = UILabel(text: "",
                                       textColor: .white.withAlphaComponent(0.5),
                                      font: UIFont(name: "SFProText-Regular", size: 12))

    public let toggleSwitch = UISwitch()
    public var isOn: Bool = true

    init(title: String, example: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        exampleLabel.text = example
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        titleLabel.textAlignment = .left
        exampleLabel.textAlignment = .left

        toggleSwitch.onTintColor = .systemGreen
        toggleSwitch.isOn = true

        addSubview(titleLabel)
        addSubview(exampleLabel)
        addSubview(toggleSwitch)
        setupConstraints()
        toggleSwitch.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview().inset(56)
            view.height.equalTo(22)
        }

        exampleLabel.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(4)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview().inset(56)
            view.bottom.equalToSuperview()
        }

        toggleSwitch.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(5)
            view.trailing.equalToSuperview()
            view.width.equalTo(48)
            view.height.equalTo(32)
        }
    }

    @objc private func toggleChanged(_ sender: UISwitch) {
        if sender.isOn {
            self.isOn = true
        } else {
            self.isOn = false
        }
        let switchState = sender.isOn

        NotificationCenter.default.post(name: Notification.Name("NotificationExample"), object: nil, userInfo: ["switchState": switchState])
    }
}
