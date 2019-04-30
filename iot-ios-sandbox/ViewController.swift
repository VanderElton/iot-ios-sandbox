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
    
    func acquireTokenInteractively() -> String {
        
        guard let client = self.client else { return token}
        
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
            
            self.token = result.idToken ?? "0.0"
            self.updateLogging(text: "Access token is \(self.token)")
            
        }
        token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Ilg1ZVhrNHh5b2pORnVtMWtsMll0djhkbE5QNC1jNTdkTzZRR1RWQndhTmsifQ.eyJleHAiOjE1NTY3MzUwNzksIm5iZiI6MTU1NjY0ODY3OSwidmVyIjoiMS4wIiwiaXNzIjoiaHR0cHM6Ly9sb2dpbi5taWNyb3NvZnRvbmxpbmUuY29tL2IxMTMyM2FlLWFjMDctNGNhOS04YjUyLTc0MTlmYjRiNDQwMS92Mi4wLyIsInN1YiI6ImViNTBiZTE5LThjMzQtNDQyMi05MTkzLTViZmE5OTNmZTM0MyIsImF1ZCI6ImZhMjcxNTUyLWQzYjgtNDE4NS1hNGZkLWRmNGNiNjNhNDIyNSIsIm5vbmNlIjoiOWFkNzc0Y2ItNTZjZi00Y2FlLWE5NTgtYzhiYTc3OGU3YjQ3IiwiaWF0IjoxNTU2NjQ4Njc5LCJhdXRoX3RpbWUiOjE1NTY2NDg2NzksImdpdmVuX25hbWUiOiJWYW5kZXIiLCJmYW1pbHlfbmFtZSI6Ik1hemllcm8iLCJuYW1lIjoiVmFuZGVyIE1hemllcm8iLCJpZHAiOiJnb29nbGUuY29tIiwib2lkIjoiZWI1MGJlMTktOGMzNC00NDIyLTkxOTMtNWJmYTk5M2ZlMzQzIiwiZW1haWxzIjpbInZhbmRlcm1hemllcm9AZ21haWwuY29tIl0sInRmcCI6IkIyQ18xX3NpZ251cGluIn0.TP3DOGe3WcAmMpbHmiywEdcFGhqTeBd0gM_MdNpWfhVdCc7cQKwFx8Dc2GrbNeqBr9bn4G2sue9o1Bdq25spbKepR5Egkqv5ti7rVCspVpikgFy2NfrQR1dDG66zalYYp_7VvOnknprRzRsuDMnkBQXxrwPpfmNKAjX6dUncPayyiAj3z39vLs_sAv6Q8_ADyPxhSbVyRroV7qh19o09fK-7TXS_ZlRO3Sxolk75VROdJ9hMBlUDwVitKjPhPQmXBkYwq-om-5GnXyBk8Xpxk2kl3EVlc8vpYx8PdRsD3tKjjLOq1XNgOL-8Ht_oa8UA-J6ebCAuZnnKKYo9Kf4Ymw"
        let _: Bool = KeychainWrapper.standard.set(token, forKey: Constants.AUTH_PREFERENCES)
        
        return token
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

