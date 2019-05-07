//
//  PlantsAPI.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 06/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class PlantsAPI {
    
    let sessionManager = Alamofire.SessionManager()
    
    func getPlants(completion: @escaping(_ plants: Array<Plant>) -> Void) {
        
        sessionManager.adapter = HeaderAdapter(idToken: KeychainWrapper.standard.string(forKey: Constants.ID_TOKEN_KEY)!)
        
        let token = "Bearer " + KeychainWrapper.standard.string(forKey: Constants.ID_TOKEN_KEY)!
        
        let head: HTTPHeaders = ["Authorization": token]
        
        Alamofire.request("https://iot-api-dev.weg.net/api/plants", headers: head).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value as? Dictionary<String, Any> {
                    guard let json = value["value"] as? Array<Dictionary<String,Any>> else {return}
                    let plants = PlantMapper().toArray(json)
                    completion(plants)
                }
                break
                
            case .failure:
                print (response.error!)
                break
            }
            
        }
    }
    
    func getPlantById(id: Int, completation: @escaping(_ plant: Plant) -> Void) {
        sessionManager.request("").responseJSON { reponse in
            switch reponse.result {
            case .success:
                if let resp = reponse.result.value as? Dictionary<String, Any> {
                    let plant = PlantMapper().toObject(resp)
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
