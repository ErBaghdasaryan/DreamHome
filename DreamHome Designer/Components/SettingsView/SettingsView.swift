//
//  SettingsView.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 13.11.24.
//

import UIKit
import DreamHomeModel

final class SettingsView: UIButton {
    private let title = UILabel(text: "",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Semibold", size: 17))
    private var image = UIImageView()

    public init(title: String, image: String) {
        self.title.text = title
        self.image.image = UIImage(named: image)
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.layer.cornerRadius = 15

        self.title.textAlignment = .left

        addSubview(title)
        addSubview(image)
        setupConstraints()
    }

    private func setupConstraints() {
        title.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(100)
            view.height.equalTo(22)
        }

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(9)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(20)
            view.height.equalTo(20)
        }
    }
}
