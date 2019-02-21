//
//  FeedViewController.swift
//  instagram
//
//  Created by Beverly Abadines on 2/19/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    let refreshController = UIRefreshControl()
    var numPosts = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refreshController.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        tableView.refreshControl = refreshController
    }
    
    @objc override func viewDidAppear(_ animated: Bool) {
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
            } else{
                self.createAlert(title: "Error", message: "\(error!.localizedDescription)")
            }
        }
        self.refreshController.endRefreshing()
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
        
        let imgFile = post["image"] as! PFFileObject
        let urlStr = imgFile.url!
        let url = URL(string: urlStr)!
        cell.photoImg.af_setImage(withURL: url)
        
        return cell
    }
}

