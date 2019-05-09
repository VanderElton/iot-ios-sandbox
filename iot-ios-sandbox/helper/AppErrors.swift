//
//  AppErrors.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 09/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation

enum AppErrors: Error {
    case PublicClientApplicationCreation(NSError)
    case UserNotFound (NSError)
    case NoUserSignedIn
}
