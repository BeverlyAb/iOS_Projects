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
    }
    
    func getPosts(){
        API.getPosts() { (posts) in
            if let posts = posts{
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoDetailVC = segue.destination as! DetailViewController
        
        let cell = sender as! PhotoCell
        
        let image = cell.mainImage.image
        
        photoDetailVC.image = image
        
    }

}


extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Basic TableViewFunctionality
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

