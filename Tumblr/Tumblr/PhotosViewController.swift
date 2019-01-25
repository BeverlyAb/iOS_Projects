//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Beverly Abadines on 1/23/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//
import Foundation
import UIKit
import AlamofireImage

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var posts : [[String : Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getPosts()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        
        //add to storyboard
        tableView.insertSubview(refreshControl, at:0)
        
        
    }
    
    // Get posts from Tumblr API
    func getPosts() {
        API.getPosts() { (posts) in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
    
    @objc func onRefresh(_ refreshControl: UIRefreshControl) {
        posts = []
        self.tableView.reloadData()
        getPosts()
        refreshControl.endRefreshing()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoDetailVC = segue.destination as! DetailViewController

        let cell = sender as! PhotoCell

        let image = cell.mainImage.image

        photoDetailVC.imagePassed = image

    }

}


extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Basic TableViewFunctionality
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.row]
        
        let url = API.getImageURL(post: post)
        cell.mainImage.af_setImage(withURL: url)
        
        return cell
    }
    
    
}

