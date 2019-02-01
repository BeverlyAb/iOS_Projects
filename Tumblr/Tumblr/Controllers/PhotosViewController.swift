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
    //Refresh
    @objc func onRefresh(_ refreshControl: UIRefreshControl) {
        posts = []
        self.tableView.reloadData()
        getPosts()
        refreshControl.endRefreshing()
    }
    //Segue to DetailViewer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoDetailVC = segue.destination as! DetailViewController
        
        let cell = sender as! PhotoCell
        
        let image = cell.mainImage.image
        
        photoDetailVC.imagePassed = image
        
    }
}

extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(posts.count)
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.section]
        
        let url = API.getImageURL(post: post)
        cell.mainImage.af_setImage(withURL: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        //profile pic
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // Set the avatar
        profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        headerView.addSubview(profileView)
        
        // Add a UILabel for the date here
        let label = UILabel(frame: CGRect(x:55, y:24, width:200, height:21))
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "Avenir-Light", size: 17.0)
        
        // Use the section number to get the right URL
        let post = posts[section]
        let timeStamp = post["timestamp"] as! Double
        
        label.text = DateUtil.formatPostTime(to: "MMM d, yyyy h:mm a", from: timeStamp)
        headerView.addSubview(label)
        
        return headerView
    }
    
}
