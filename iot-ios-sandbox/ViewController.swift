//
//  ViewController.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 26/04/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import UIKit
import MSAL


class ViewController: UIViewController,URLSessionDelegate {
    
    //Mark: Properties
    @IBOutlet weak var acessButton: UIButton!
    @IBOutlet weak var statusText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            guard let authorityURL = URL(string: String(format: Constants.ENDPOINT, Constants.TENANT, Constants.POLICY)) else {
                self.statusText
                return
                
            }
            let AUTHORITY = try MSALAuthority (url: authorityURL)
            
        }catch let error{
            self.
        }
    }
    
    //Mark: Actions
    @IBAction func actionAcessButton(_ sender: UIButton) {
        
        do{
            let client = try MSALPublicClientApplication.init(clientId: Constants.CLIENT_ID, authority: AUTHORITY)
            
            client.acquireToken(forScopes: Constants.Scope){ (result,error) in
                guard let authResult = result, error == nil else{
                    return
                }
                let acessToken = authResult.accessToken
            }
        }catch{
            
        }
    }


}

