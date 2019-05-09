//
//  AuthViewController.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 06/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var acessButton: UIButton!
    
    //Mark: Properties

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Mark: Actions
    @IBAction func actionAcessButton(_ sender: UIButton) {
        
        MSALAuthentication.shared.signInAccount {
            (account, token, error) in
            if let error = error {
                print ("App error: \(error)")
                return
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.showMainViewController()
        }
    }
}
