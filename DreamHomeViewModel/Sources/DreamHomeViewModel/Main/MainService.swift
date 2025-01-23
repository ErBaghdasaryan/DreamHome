//
//  MainService.swift
//  DreamHomeViewModel
//
//  Created by Er Baghdasaryan on 23.01.25.
//

import UIKit
import DreamHomeModel

public protocol IMainService {
    func getMainItems() -> [MainPresentationModel]
}

public class MainService: IMainService {
    public init() { }

    public func getMainItems() -> [MainPresentationModel] {
        [
            MainPresentationModel(image: "Img-74",
                                  header: "Luck is on your side!",
                                  description: "Play and earn money"),
            MainPresentationModel(image: "Img-75",
                                  header: "Rate our app in the AppStore",
                                  description: "Help make the app even better"),
            MainPresentationModel(image: "Img-76",
                                  header: "Be always informed",
                                  description: "Don't miss anything important."),
        ]
    }
}
