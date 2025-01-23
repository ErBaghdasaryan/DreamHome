//
//  FeatureViewModel.swift
//  DreamHomeViewModel
//
//  Created by Er Baghdasaryan on 23.01.25.
//

import Foundation
import DreamHomeModel

public protocol IFeatureViewModel {
    var url: String { get }
    var appStorageService: IAppStorageService { get set }
}

public class FeatureViewModel: IFeatureViewModel {

    public var url: String {
        get {
            return appStorageService.getData(key: .webUrl) ?? ""
        }
    }

    private let featureService: IFeatureService
    public var appStorageService: IAppStorageService

    public init(featureService: IFeatureService,
                appStorageService: IAppStorageService) {
        self.featureService = featureService
        self.appStorageService = appStorageService
    }
}
