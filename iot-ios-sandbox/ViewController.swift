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
import SwiftyJSON


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
        
        do {
            try self.initMSAL()
        }catch let error {
            self.statusText.text = "client error \(error)"
        }
        
    }
    
    //Mark: Actions
    @IBAction func actionAcessButton(_ sender: UIButton) {
        
        acquireTokenInteractively()
        
    }

    func initMSAL() throws {
    
    /*guard let authorityURL = URL(string: Constants.AUTHORITY) else {
        self.statusText.text = "Unable to create authority URL"
        return
    }
    
    let authority = try MSALB2CAuthority(url: authorityURL)
         
    let msalConfiguration = MSALPublicClientApplicationConfig(clientId: Constants.CLIENT_ID, redirectUri: nil, authority: authority)
    */
        
    
    let msalConfiguration = MSALPublicClientApplicationConfig(clientId: Constants.CLIENT_ID)
        
    self.client = try MSALPublicClientApplication(configuration: msalConfiguration)
        
    }
    
    func acquireTokenInteractively() {
        
        guard let client = self.client else { return }
        
        let parameters = MSALInteractiveTokenParameters(scopes: Constants.SCOPES)
        
        client.acquireToken(with: parameters) { (result, error) in
            
            if let error = error {
                
                self.updateLogging(text: "Could not acquire token: \(error)")
                return
            }
            
            guard let result = result else {
                
                self.updateLogging(text: "Could not acquire token: No result returned")
                return
            }
            
            self.token = result.idToken ?? "0"
            self.updateLogging(text: "Access token is \(self.token)")
            
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
    
    /*
    func acClient(){
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
    
    func acToken(){
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
 */

}

