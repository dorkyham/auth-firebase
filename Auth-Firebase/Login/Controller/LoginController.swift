//
//  LoginController.swift
//  Auth-Firebase
//
//  Created by Annisa Nabila Nasution on 10/06/20.
//  Copyright © 2020 Annisa Nabila Nasution. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passTF: UITextField!
    
    @IBAction func onClick(_ sender: Any) {
        performSegue(withIdentifier: "goToRegister", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passTF.isSecureTextEntry = true
    }
    
    @IBAction func loginOnClick(_ sender: Any) {
        if emailTF.text == "" || passTF.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Empty Textfield", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            Auth.auth().signIn(withEmail: emailTF.text!, password: passTF.text!) { (result, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Alert", message: "Failed login to account", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                        self.performSegue(withIdentifier: "goToHome", sender: nil)
                    }
                }
            }
        }
        
    }


