//
//  RegisterController.swift
//  Auth-Firebase
//
//  Created by Annisa Nabila Nasution on 10/06/20.
//  Copyright © 2020 Annisa Nabila Nasution. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

class RegisterController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpOnClick(_ sender: Any) {
        if usernameTF.text == "" || emailTF.text == "" || passwordTF.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Empty Textfield", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let name: String? = usernameTF.text
            let email:String? = emailTF.text
            let pass: String? = passwordTF.text
            
            
            Auth.auth().createUser(withEmail: email!, password: pass!) { (result, err) in
            if err != nil{
                //show error msg
                let alert = UIAlertController(title: "Alert", message: "Failed create new user data", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["name":name!, "email":email!, "password":pass!, "uid":result!.user.uid]) {
                    (error) in
                        if error != nil {
                        //show error msg
                            print(error)
                            let alert = UIAlertController(title: "Alert", message: "Failed storing data to database", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else{
                            self.performSegue(withIdentifier: "goToLogin", sender: nil)
                        }
                    }
                
                }
            }
        }
    }
    
    @IBAction func onClick(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion:nil)
        performSegue(withIdentifier: "goToLogin", sender:  nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
