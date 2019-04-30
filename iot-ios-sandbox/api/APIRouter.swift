//
//  APIRouter.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 30/04/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Alamofire
import SwiftKeychainWrapper

enum APIRouter: URLRequestConvertible {
    
    case get
    case post
    
    // MARK: HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .post:
            return .post
        default:
            return .get
        }
    }
    
    // Mark: Path
    private var path: String {
        switch self {
        case .post:
            return "/post"
        default:
            return "/get"
        }
    }
    
    /*// Mark: Parameters
    private var parameters: Parameters? {
        switch self {
        case .post:
            <#code#>
        default:
            <#code#>
        }
    }*/
    
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try Constants.BASE_URL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        let token: String? = KeychainWrapper.standard.string(forKey: Constants.AUTH_PREFERENCES)
        
        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}
