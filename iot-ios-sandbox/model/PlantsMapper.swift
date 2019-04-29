//
//  PlantsMapper.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 29/04/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation

class MovieMapper {
    
    func toObject(_ object: Dictionary<String, Any>) -> Plants{
        let plant = Plants(name: object["name"] as! String, description: object["description"] as! String)
        return plant
    }
    
    func toArray(_ array: Array<Dictionary<String, Any>>) -> Array<Plants> {
        var plants: Array<Plants> = []
        for plant in array {
            plants.append(self.toObject(plant))
        }
        return plants
    }
    
}

