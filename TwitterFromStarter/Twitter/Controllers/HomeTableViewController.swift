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
    var numTweet : Int!
    
    func loadTweet(){
        let homeUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParam = ["count" : 1]
        
        
        //tweets is the expected dict output
        TwitterAPICaller.client?.getDictionariesRequest(url: homeUrl, parameters: myParam, success: { (tweets: [NSDictionary]) in
            self.tweetArr.removeAll()
            for tweet in tweets{
                self.tweetArr.append(tweet)
            }
            print("Loaded tweets")
        }, failure: { (Error) in
            print("Could not load tweets")
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.delegate = self
        //tableView.dataSource = self
        loadTweet()
        
        //refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.insertSubview(refreshControl, at:0)
        
    }
    
    //Refresh
    @objc func onRefresh(_ refreshControl: UIRefreshControl) {
        tweetArr.removeAll()
        self.tableView.reloadData()
        loadTweet()
        refreshControl.endRefreshing()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        
        //dismiss =make sure Login closes back to Login, nil = don't want anything to happen once it's gone
        self.dismiss(animated: true, completion: nil)
        
        //lose user info. Make sure to use same key
        UserDefaults.standard.set(false, forKey:"userLoggedIn")
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        //cell.tweetText.text = tweetArr[indexPath.row]["text"] as! String
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//tweetArr.count
    }



}