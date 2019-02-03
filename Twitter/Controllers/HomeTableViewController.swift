//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Beverly Abadines on 2/3/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
           //dismiss =make sure Login closes back to Login, nil = don't want anything to happen once it's gone
        self.dismiss(animated: true, completion: nil)
        
        //lose user info. Make sure to use same key
        UserDefaults.standard.set(false, forKey:"userLoggedIn")
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 

}
