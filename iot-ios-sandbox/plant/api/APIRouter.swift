//
//  APIRouter.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 13/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//
import Alamofire

public enum APIRouter: URLRequestConvertible {
    
    case getPlant
    case getPlantById(String)
    case postPlant
    
    var method: HTTPMethod {
        switch self {
        case .postPlant:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        switch  self {
        case .getPlant:
            return "/plants"
        case .getPlantById(let id):
            return "/plants/\(id)"
        default:
            return ""
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        default:
            return [:]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        var token = ""
        
        if (MSALAuthentication.shared.currentTokenId != nil) {
            token = "Bearer " + MSALAuthentication.shared.currentTokenId!
        }
            
        let url = try Constants.BASE_URL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.setValue(token, forHTTPHeaderField: "Authorization")
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
