//
//  Device.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 13/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation

class Device {
    let id: String?
    let enabled: String?

    init(id: String, enabled: String) {
        self.id = id
        self.enabled = enabled
    }
}
