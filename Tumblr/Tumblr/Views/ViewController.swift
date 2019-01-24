//
//  ViewController.swift
//  Tumblr
//
//  Created by Beverly Abadines on 1/22/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    //arr of dict
    var posts : [[String :Any ]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getPosts()
    }
    
    //retrieve images and data
    func getPosts(){
        API.getPosts() { (post) in
            if let posts = posts{
                self.posts = posts
                self.tableView.reloadData()
            }

        }
    }
    
    //control segue when img is triggered
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DisplayImage = segue.destination as! PhotosViewController
        
        let cell = sender as! PhotosTableViewCell
        
        let image = cell.displayImg.image
        
    }

    extension PhotosViewController: UITableViewDataSource, UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell") as! PhotosTableViewCell
            
            let post = posts[indexPath.row]
            
            let url = API.getImageURL(post : post)
            cell.photoImageView.af_setImage(withURL : url)
            return cell
        }
    }
}

