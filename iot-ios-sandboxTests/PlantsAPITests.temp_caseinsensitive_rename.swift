//
//  plantsAPITests.swift
//  iot-ios-sandboxTests
//
//  Created by ITLABS WEG on 14/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import XCTest
@testable import iot_ios_sandbox

class PlantsAPITests: XCTestCase {
    
    var json: [String: Any] = [
        
            "name":"name.test",
            "description":"description.test",
            "id":"id.test",
            "plantType":"plantType.test",
            "devices":[]
    ]

    func testPlantMapper() {
        let r = PlantMapper().toObject(json)
        XCTAssertEqual(r.name, "name.test")
        XCTAssertEqual(r.description, "description.test")
        XCTAssertEqual(r.id, "id.test")
        XCTAssertEqual(r.plantType, "plantType.test")
    }

}
