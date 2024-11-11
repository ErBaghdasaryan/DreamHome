//
//  UIDevice.swift
//  DreamHome Designer
//
//  Created by Er Baghdasaryan on 11.11.24.
//

import UIKit

enum DeviceType {
    case iPhone
    case iPad
}

extension UIDevice {
    static var currentDeviceType: DeviceType {
        return UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone
    }
}
