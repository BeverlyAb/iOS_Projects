//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Beverly Abadines on 1/23/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var posts : [[String : Any]] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        
        let post = posts[indexPath.row]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = post["poster_path"] as! String
        
        let posterUrl = URL(string: baseUrl + posterPath)
        cell.mainImage.af_setImage(withURL: posterUrl!)
        return cell
    }
    
    
    func getPosts(){
        API.getPosts() { (posts) in
            if let posts = posts{
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoDetailVC = segue.destination as! PhotosViewController
        
        let cell = sender as! PhotoCell
        
        let image = cell.mainImage.image
        
    }

}

