//
//  EmptyTableViewCell.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 14.11.24.
//

import UIKit
import SnapKit
import DreamHomeModel

class EmptyTableViewCell: UITableViewCell, IReusableView {
    private let emptyLabel = UILabel(text: "There is no collection of passwords here yet. Create a new collection by clicking on the button below or generate a collection of passwords in the «Generator» tab",
                                     textColor: UIColor.white,
                                     font: UIFont(name: "SFProText-Semibold", size: 17))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    public func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none

        self.emptyLabel.numberOfLines = 4
        addSubview(emptyLabel)

        emptyLabel.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }
}
