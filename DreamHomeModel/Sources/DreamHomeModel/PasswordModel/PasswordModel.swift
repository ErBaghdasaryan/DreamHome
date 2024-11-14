//
//  PasswordModel.swift
//
//
//  Created by Er Baghdasaryan on 14.11.24.
//

import UIKit

public struct PasswordModel {
    public let id: Int?
    public let name: String
    public let passwords: [String]

    public init(id: Int? = nil, name: String, passwords: [String]) {
        self.id = id
        self.name = name
        self.passwords = passwords
    }
}
