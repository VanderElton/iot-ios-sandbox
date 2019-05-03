//
//  ViewController.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 26/04/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import UIKit
import MSAL
import Alamofire
import SwiftKeychainWrapper


class ViewController: UIViewController,URLSessionDelegate,UITextFieldDelegate {
    
    var client : MSALPublicClientApplication?
    
    var token = String()
    
    //Mark: Properties
    @IBOutlet weak var acessButton: UIButton!
    
    @IBOutlet weak var statusText: UITextField!
    
    @IBOutlet weak var viewTable: UITableView!
    var arrRes = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
    }
    
    //Mark: Actions
    @IBAction func actionAcessButton(_ sender: UIButton) {
        
        do {
            
            let uri = "msauth.net.weg.iot-ios-sandbox://auth"
            
            let urlStringAuthority = String(format: Constants.ENDPOINT, arguments: [Constants.TENANT,Constants.POLICY])
            
            guard let urlAuthority = URL(string: urlStringAuthority) else { return }
            
            let authority = try MSALB2CAuthority(url: urlAuthority)
            
            let config = MSALPublicClientApplicationConfig(clientId: Constants.CLIENT_ID, redirectUri: uri, authority: authority)
            
            do {
                client = try MSALPublicClientApplication(configuration: config)
            }catch let error as NSError {
                throw error
            }
            
            let parameters = MSALInteractiveTokenParameters(scopes: Constants.SCOPES)
        
            client?.acquireToken(with: parameters) { (result: MSALResult?, error: Error?) in
            
            if let error = error {
                
                self.updateLogging(text: "Could not acquire token: \(error)")
                return
            }
            
            guard let result = result else {
                
                self.updateLogging(text: "Could not acquire token: No result returned")
                return
            }
            
            self.token = result.idToken ?? "0.0"
            self.updateLogging(text: "Access token is \(self.token)")
            
        }
        
        let _: Bool = KeychainWrapper.standard.set(token, forKey: Constants.AUTH_PREFERENCES)
            
        }catch{
            print("oo")
        }
        
    }

    
    func updateLogging(text : String) {
        
        if Thread.isMainThread {
            self.statusText.text = text
        } else {
            DispatchQueue.main.async {
                self.statusText.text = text
            }
        }
    }

}

