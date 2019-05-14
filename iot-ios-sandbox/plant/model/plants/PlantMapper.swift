//
//  PlantMapper.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 06/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation

class PlantMapper {
    
    func toObject(_ object: Dictionary<String, Any>) -> Plant{
        let plant = Plant(name: object["name"] as? String ?? "", description: object["description"] as? String ?? "", id: object["id"] as? String ?? "", plantType: object["plantType"] as? String ?? "", devices: object["devices"] as? [Device] ?? [])
        
        return plant
    }
    
    func toArray(_ array: Array<Dictionary<String, Any>>) -> Array<Plant> {
        var plants: Array<Plant> = []
        for plant in array {
            plants.append(self.toObject(plant))
        }
        
        return plants
    }
    
}
