//
//  FeedViewController.swift
//  instagram
//
//  Created by Beverly Abadines on 2/19/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse
class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
        //query
        let query = PFQuery(className: "Posts")
        query.includeKey("author") //fetches obj from pointer
        query.limit = 20
        
        //store data
        query.findObjectsInBackground{(posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
            
        }
        
    }
}
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.authorLabel.text = user.username
        cell.captionLabel.text = post["caption"] as! String
        
        return cell
    }
}

