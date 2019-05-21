//
//  Constants.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 06/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation

public struct Constants {

    static let ENDPOINT = "https://login.microsoftonline.com/tfp/%@/%@"
    static let CLIENT_ID = "57e0c229-158f-4052-bd17-f757a5189da2"
    static let SCOPES: [String] = ["https://devwegme.onmicrosoft.com/apps-sandbox/read.write"]
    static let POLICY = "B2C_1_signupin"
    static let TENANT = "devwegme.onmicrosoft.com"
    static let BASE_URL = "https://iot-api-dev.weg.net/api"

    /* UserDefaults KEYS */
    static let ID_TOKEN_KEY = "msal.idtoken"
    static let ACCOUNT_ID = "msal.currentAccountIdentifier"

}
