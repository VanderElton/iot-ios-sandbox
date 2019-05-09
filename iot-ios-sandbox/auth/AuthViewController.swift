//
//  AuthViewController.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 06/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import UIKit
import MSAL
import SwiftKeychainWrapper

class AuthViewController: UIViewController, URLSessionDelegate {
    
    var client : MSALPublicClientApplication?
    
    var isSeguePending: Bool = false
    
    var token = String()
    @IBOutlet weak var acessButton: UIButton!
    
    //Mark: Properties

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.isSeguePending {
            self.isSeguePending = false
            self.performSegue(withIdentifier: "SeguePlantsStoryboard", sender: self)
        }
    }
    
    //Mark: Actions
    @IBAction func actionAcessButton(_ sender: UIButton) {
        do {
            client = try createClient()
            
            acquireTokenInteractive(forScopes: Constants.SCOPES, client: client!)
            
        }catch{
            return
        }
    }
    
    func createClient () throws -> MSALPublicClientApplication {
        
        let urlStringAuthority = String(format: Constants.ENDPOINT, arguments: [Constants.TENANT,Constants.POLICY])
        
        let urlAuthority = URL(string: urlStringAuthority)!
        
        let authority = try MSALB2CAuthority(url: urlAuthority)
        
        let config = MSALPublicClientApplicationConfig(clientId: Constants.CLIENT_ID, redirectUri: nil, authority: authority)
        
        return try MSALPublicClientApplication(configuration: config)
        
    }
    
    func acquireTokenInteractive (forScopes scopes: [String], client: MSALPublicClientApplication) {
        
        let parameters = MSALInteractiveTokenParameters(scopes: Constants.SCOPES)
        
        client.acquireToken(with: parameters) { (result: MSALResult?, error: Error?) in
            
            guard let acquireResult = result, error == nil else {
                return
            }
            self.token = acquireResult.idToken!
            let _: Bool = KeychainWrapper.standard.set(self.token, forKey: Constants.ID_TOKEN_KEY)
            self.isSeguePending = true
        }
    }

}
