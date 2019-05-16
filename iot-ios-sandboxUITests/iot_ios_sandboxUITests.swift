//
//  iot_ios_sandboxUITests.swift
//  iot-ios-sandboxUITests
//
//  Created by ITLABS WEG on 06/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import XCTest
@testable import iot_ios_sandbox

class iot_ios_sandboxUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }

    override func tearDown() {
        
    }

    func testExample() {
        
        app = XCUIApplication()
        app.launchArguments = ["Test"]
        app.launch()
    }

}
