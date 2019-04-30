//
//  TokenAdapter.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 30/04/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation
import Alamofire

final class TokenAdapter: RequestAdapter {
    
    private let idToken: String
    
    init (idToken: String) {
        self.idToken = idToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Constants.BASE_URL) {
            urlRequest.setValue("Bearer " + idToken, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
}
