//
//  PasswordNavigationModel.swift
//
//
//  Created by Er Baghdasaryan on 15.11.24.
//

import Foundation
import Combine

public final class PasswordNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: PasswordModel

    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: PasswordModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
