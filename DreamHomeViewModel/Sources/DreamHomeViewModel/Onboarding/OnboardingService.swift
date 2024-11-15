//
//  OnboardingService.swift
//
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import UIKit
import DreamHomeModel

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentationModel]
}

public class OnboardingService: IOnboardingService {
    public init() { }

    public func getOnboardingItems() -> [OnboardingPresentationModel] {
        [
            OnboardingPresentationModel(image: "firstOnboarding",
                                        header: "Generate unique passwords",
                                        description: "Many different options"),
            OnboardingPresentationModel(image: "secondOnboarding",
                                        header: "Keep your passwords in a convenient list",
                                        description: "Manage passwords")
        ]
    }
}
