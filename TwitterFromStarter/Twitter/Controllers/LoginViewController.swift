//
//  LoginViewController.swift
//  Twitter
//
//  Created by Beverly Abadines on 2/5/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginButton(_ sender: Any) {
        let twitterUrl : String = "https://api.twitter.com/oauth/request_token"
        
        //sender = where is transition coming from?
        TwitterAPICaller.client?.login(url: twitterUrl, success: {
            //retain user info
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            print("Success")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Could not log in")
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //appears when login page shows up
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
}
