//
//  Setupable.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}
