//
//  iot_ios_sandboxUITests.swift
//  iot-ios-sandboxUITests
//
//  Created by ITLABS WEG on 06/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import XCTest
@testable import iot_ios_sandbox

class IOSUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        UserDefaults.standard.set(".", forKey: "msal.idtoken")
    }

    override func tearDown() {
        app.terminate()
    }

    func testMainView() {
        
        app = XCUIApplication()
        app.launchArguments = ["Test"]
        app.launch()
        
        app.navigationBars["WEG"].buttons["Sair"].tap()
        
    }
    
    func testLoginView() {
        
        app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Acess"].isHittable)
    }

}
