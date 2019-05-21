//
//  DeviceMapper.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 13/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation

class DeviceMapper {

    func toObject(_ object: [String: Any]) -> Device {
        let device = Device(id: object["id"] as? String ?? "", enabled: object["enabled"] as? String ?? "")

        return device
    }

    func toArray(_ array: [[String: Any]]) -> Array<Device> {
        var devices: [Device] = []
        for device in array {
            devices.append(self.toObject(device))
        }

        return devices
    }

}
