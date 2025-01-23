//
//  MainViewModel.swift
//  DreamHomeViewModel
//
//  Created by Er Baghdasaryan on 23.01.25.
//

import Foundation
import DreamHomeModel

public protocol IMainViewModel {
    var mainItems: [MainPresentationModel] { get set }
    func loadData()
}

public class MainViewModel: IMainViewModel {

    private let mainService: IMainService

    public var mainItems: [MainPresentationModel] = []

    public init(mainService: IMainService) {
        self.mainService = mainService
    }

    public func loadData() {
        mainItems = mainService.getMainItems()
    }
}
