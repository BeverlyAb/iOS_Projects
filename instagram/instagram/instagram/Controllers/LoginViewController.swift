//
//  LoginViewController.swift
//  instagram
//
//  Created by Beverly Abadines on 2/20/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = userTextField.text!
        let password = pwTextField.text!
        
        //user already exists, no need to create
        //user can be user or nil
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if (user != nil){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                self.createAlert(title: "Error", message: "\(error!.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = userTextField.text
        user.password = pwTextField.text
        
        //(bool, error)
        user.signUpInBackground{ (success, error) in
            if (success){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                self.createAlert(title: "Error", message: "\(error!.localizedDescription)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
     //------------------------Error Message  -------------
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
    }
}
