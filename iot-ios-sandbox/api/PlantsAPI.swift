//
//  PlantsAPI.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 30/04/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class PlantsAPI {
    
    var urlRequest = URLRequest(url: URL(string: "https://iot-api-dev.weg.net")!)
    
    let sessionManager = Alamofire.SessionManager()
    
    func getPlants(completion: @escaping(_ plants: Array<Plants>) -> Void) {
        
        sessionManager.adapter = TokenAdapter(idToken: KeychainWrapper.standard.string(forKey: Constants.AUTH_PREFERENCES)!)
        
        Alamofire.request("https://iot-api-dev.weg.net/plants").validate().responseJSON { response in
            switch response.result {
            case .success:
                if let resp = response.result.value as? Dictionary<String, Any> {
                    guard let json = resp["results"] as? Array<Dictionary<String, Any>> else {return}
                    let plants = PlantsMapper().toArray(json)
                    completion(plants)
                }
                break
                
            case .failure:
                print (response.error!)
                break
            }
            
        }
    }
    
    func getPlantById(id: Int, completation: @escaping(_ plant: Plants) -> Void) {
        sessionManager.request("").responseJSON { reponse in
            switch reponse.result {
            case .success:
                if let resp = reponse.result.value as? Dictionary<String, Any> {
                    let plant = PlantsMapper().toObject(resp)
                    completation(plant)
            }
                break
            case .failure:
                print(reponse.error!)
                break
            }
        }
    }
}
