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
                
                let alert = UIAlertController(title: "Erro", message: "Verifique a conexao", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.showMainViewController()
        }
    }
}