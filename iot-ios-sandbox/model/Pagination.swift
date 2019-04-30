//
//  Pagination.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 30/04/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation

class Pagination {
    let bookmark: String?
    let count: Int?
    let value: [Plants]
    
    init(bookmark: String, count: Int, value: [Plants]) {
        self.bookmark = bookmark
        self.count = count
        self.value = value
    }
}

