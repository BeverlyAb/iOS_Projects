//
//  ViewController.swift
//  Tumblr
//
//  Created by Beverly Abadines on 1/22/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    //arr of dict
   // var posts : [[String :Any ]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        //getPost()
    }
    
//    func getPosts(){
//        API.getPosts() { (post) in
//
//        }
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

