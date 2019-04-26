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
    
    var client : MSALPublicClientApplication?
    
    //Mark: Properties
    @IBOutlet weak var acessButton: UIButton!
    @IBOutlet weak var statusText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            guard let authorityURL = URL(string: String(format: Constants.ENDPOINT, Constants.TENANT, Constants.POLICY)) else {
                self.statusText.text = "Error URL"
                return
                
            }
            let AUTHORITY = try MSALAuthority (url: authorityURL)
            
            self.client = try MSALPublicClientApplication.init(clientId: Constants.CLIENT_ID, authority: AUTHORITY)
            
        }catch let error{
            self.statusText.text = "Error to create App Context \(error)"
        }
        
    }
    
    //Mark: Actions
    @IBAction func actionAcessButton(_ sender: UIButton) {
        
        guard let client = self.client else {return}
        
        client.acquireToken(forScopes: Constants.SCOPES){ (result,error) in
            
            if let error = error{
                self.statusText.text = "ERROR: \(error)"
            }
            
            guard let result = result else{
                self.statusText.text = "ERROR"
                return
            }
            
            self.statusText.text = "Token: \(result)"
            }

    }

}

