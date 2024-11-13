//
//  SliderView.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 13.11.24.
//

import UIKit

class SliderView: UIView {

    private let titleLabel = UILabel(text: "",
                                     textColor: .white,
                                     font: UIFont(name: "SFProText-Bold", size: 22))

    public let lengthLabel = UILabel(text: "",
                                      textColor: .white,
                                      font: UIFont(name: "SFProText-Semibold", size: 17))

    private let slider = UISlider()

    private let minLabel = UILabel(text: "",
                                   textColor: .white,
                                   font: UIFont(name: "SFProText-Regular", size: 17))

    private let maxLabel = UILabel(text: "",
                                  textColor: .white,
                                  font: UIFont(name: "SFProText-Regular", size: 17))

    init(title: String, labelNumber: Float, startNumber: Float, endNumber: Float) {
        super.init(frame: .zero)
        slider.minimumValue = startNumber
        slider.maximumValue = endNumber
        slider.value = labelNumber
        titleLabel.text = title
        lengthLabel.text = "\(Int(labelNumber))"
        minLabel.text = "\(Int(startNumber))"
        maxLabel.text = "\(Int(endNumber))"
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {

        lengthLabel.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        lengthLabel.layer.cornerRadius = 8
        lengthLabel.layer.masksToBounds = true

        slider.minimumTrackTintColor = UIColor(hex: "#FF2300")
        slider.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.05)
        slider.thumbTintColor = UIColor(hex: "#FF2300")

        titleLabel.textAlignment = .left

        addSubview(titleLabel)
        addSubview(lengthLabel)
        addSubview(minLabel)
        addSubview(maxLabel)
        addSubview(slider)
        setupConstraints()
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(28)
        }

        lengthLabel.snp.makeConstraints { view in
            view.top.equalTo(titleLabel.snp.bottom).offset(8)
            view.leading.equalToSuperview()
            view.bottom.equalToSuperview()
            view.width.equalTo(64)
        }

        minLabel.snp.makeConstraints { view in
            view.centerY.equalTo(lengthLabel.snp.centerY)
            view.leading.equalTo(lengthLabel.snp.trailing).offset(16)
            view.width.equalTo(32)
            view.height.equalTo(22)
        }

        maxLabel.snp.makeConstraints { view in
            view.centerY.equalTo(minLabel.snp.centerY)
            view.trailing.equalToSuperview()
            view.width.equalTo(32)
            view.height.equalTo(22)
        }

        slider.snp.makeConstraints { view in
            view.centerY.equalTo(minLabel.snp.centerY)
            view.leading.equalTo(minLabel.snp.trailing).offset(8)
            view.trailing.equalTo(maxLabel.snp.leading).inset(-8)
            view.height.equalTo(4)
        }
    }

    @objc private func sliderValueChanged(_ sender: UISlider) {
        let length = Int(sender.value)
        lengthLabel.text = "\(length)"
    }
}

