//
//  MSALAuthenticationTests.swift
//  iot-ios-sandboxTests
//
//  Created by ITLABS WEG on 14/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import XCTest
@testable import iot_ios_sandbox

class MSALAuthenticationTests: XCTestCase {

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {

    }

    func testStoreTokenInUserPreferences() {

        let tokenValue = "token.value.for.test"
        MSALAuthentication.shared.currentTokenId = tokenValue

        XCTAssertEqual(UserDefaults.standard.string(forKey: Constants.ID_TOKEN_KEY), tokenValue)

        MSALAuthentication.shared.clearCurrentAccount()

        XCTAssertNil(UserDefaults.standard.string(forKey: Constants.ID_TOKEN_KEY))
    }

    func testRouteApiURL() {

        let tokenValue = "token.value.for.test"
        MSALAuthentication.shared.currentTokenId = tokenValue

        let route = APIRouter.getPlant
        let headContains = (route.urlRequest?.allHTTPHeaderFields?.values.contains("Bearer " + tokenValue))!
        XCTAssert(headContains)
        XCTAssertEqual(route.urlRequest?.description, "https://iot-api-dev.weg.net/api/plants")
    }

    func testMSALReturnClient() {
        do {
            let client = try MSALAuthentication.shared.createClientApplication()
            XCTAssertEqual(client.clientId, Constants.CLIENT_ID)
            XCTAssertNotNil(client.redirectUri)
        } catch {
            return
        }
    }

}
