//
//  Plant.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 06/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation

class Plant {
    let name: String?
    let description: String?
    let id: String?
    let plantType: String?
    
    init(name: String, description: String, id: String, plantType: String){
        self.name = name
        self.description = description
        self.id = id
        self.plantType = plantType
    }
}
