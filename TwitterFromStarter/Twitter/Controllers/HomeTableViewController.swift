//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Beverly Abadines on 2/5/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArr = [NSDictionary]()
    var numTweet = 10
    var staticNum = 5
    let refreshController = UIRefreshControl()
    
    @IBAction func logoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        
        //dismiss =make sure Login closes back to Login, nil = don't want anything to happen once it's gone
        self.dismiss(animated: true, completion: nil)
        
        //lose user info. Make sure to use same key
        UserDefaults.standard.set(false, forKey:"userLoggedIn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        
        //refresh
        refreshController.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = refreshController
    }
    
    @objc func loadTweet(){
        let homeUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParam = ["count" : numTweet]
        
        //tweets is the expected dict output
        TwitterAPICaller.client?.getDictionariesRequest(url: homeUrl, parameters: myParam, success: { (tweets: [NSDictionary]) in
            self.tweetArr.removeAll()
            for tweet in tweets{
                self.tweetArr.append(tweet)
            }
            //SUPER IMPORTANT DO NOT FORGET
            self.tableView.reloadData()
            print("Loaded tweets")
        
        }, failure: { (Error) in
            print("Could not load tweets")
        })
        self.refreshController.endRefreshing()
    }
    
    //endless scroll of tweets
    func loadInfTweet(){
        let homeUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numTweet = numTweet + 5
        
        let myParam = ["count" : numTweet]
        //tweets is the expected dict output
        TwitterAPICaller.client?.getDictionariesRequest(url: homeUrl, parameters: myParam, success: { (tweets: [NSDictionary]) in
            self.tweetArr.removeAll()
            for tweet in tweets{
                self.tweetArr.append(tweet)
            }
            //SUPER IMPORTANT DO NOT FORGET
            self.tableView.reloadData()
            print("Loaded tweets")
            
        }, failure: { (Error) in
            print("Could not load tweets")
        })
        self.refreshController.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row  == 4 {
            print("Row Index ", indexPath.row)
            staticNum = staticNum + numTweet
        }
//        if indexPath.row + 1 == tweetArr.count {
//            loadInfTweet()
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
    
        cell.tweetText.text = tweetArr[indexPath.row]["text"] as? String
        let user = tweetArr[indexPath.row]["user"] as! NSDictionary
        cell.userName.text = user["name"] as? String
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)

        if let imageData = data{
            cell.profileImg.image = UIImage(data : imageData)
        }
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("staticNum " ,staticNum)
//        return staticNum
        return tweetArr.count
    }



}
