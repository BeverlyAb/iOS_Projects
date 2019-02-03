//
//  LoginViewController.swift
//  Twitter
//
//  Created by Beverly Abadines on 2/3/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func onLoginButton(_ sender: Any) {
        let twitterUrl : String = "https://api.twitter.com/oauth/request_token"
        
        //sender = where is transition coming from?
        TwitterAPICaller.client?.login(url: twitterUrl, success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Could not log in")
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
