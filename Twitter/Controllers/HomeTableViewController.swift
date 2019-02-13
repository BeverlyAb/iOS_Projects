//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Beverly Abadines on 2/5/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import AlamofireImage
class HomeTableViewController: UITableViewController {

    var tweetArr = [NSDictionary]()
    var numTweet = 40
    var staticNum = 40
    let refreshController = UIRefreshControl()
    var failedToLoad = true
    
    @IBAction func logoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        //dismiss =make sure Login closes back to Login, nil = don't want anything to happen once it's gone
        self.dismiss(animated: true, completion: nil)
        //lose user info. Make sure to use same key
        UserDefaults.standard.set(false, forKey:"userLoggedIn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //refresh
        refreshController.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = refreshController
    }
    
    //-----------------updates view everytime there is a change------------------
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true) //must always call this FIRST, then add custom
        self.loadTweet()
    }
    
    //--------------------------------loads tweets--------------------------------
    @objc func loadTweet(){
        let homeUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParam = ["count" : numTweet]
        
        //tweets is the expected dict output
        TwitterAPICaller.client?.getDictionariesRequest(url: homeUrl, parameters: myParam, success: { (tweets: [NSDictionary]) in
            self.tweetArr.removeAll()
            for tweet in tweets{
                self.tweetArr.append(tweet)
            }
            self.failedToLoad = false
            print("Loaded tweets")
            
            self.tableView.reloadData()
            self.refreshController.endRefreshing()
        }, failure: { (Error) in
            self.failedToLoad = true
            print("Could not load tweets \(Error)")
            self.createAlert(title: "Uh Oh,", message: "Tweets could not be loaded")
            self.refreshController.endRefreshing()
        })
        
    }
    
    //-------------endless scroll of tweets------------------------------------------------
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
            self.failedToLoad = false
            print("Loaded tweets")
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            self.failedToLoad = true
            print("Could not load tweets \(Error)")
            self.createAlert(title: "Uh Oh,", message: "Tweets could not be loaded")
        })
     
    }
    //--------------------------calls for endless scrolling--------------------------------
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (failedToLoad){
            //print(indexPath.row)
            if (indexPath.row  + 1 == staticNum){
                //print("Row Index ", indexPath.row)
                staticNum = staticNum + numTweet
                 self.tableView.reloadData()
                }
            
        } else{
            if (indexPath.row + 1 == tweetArr.count ){
                loadInfTweet()
                //debug
                self.tableView.reloadData()
            }
        }
    }
    
    
    //--------------tableview (refreshes after reloadData()--------------------------------
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        if (!failedToLoad){
            cell.tweetText.text = tweetArr[indexPath.row]["text"] as? String
            let user = tweetArr[indexPath.row]["user"] as! NSDictionary
            cell.userName.text = user["name"] as? String
            let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
            let data = try? Data(contentsOf: imageURL!)

            if let imageData = data{
                cell.profileImg.image = UIImage(data : imageData)
            }
            
        }
        //set fav, id, retweet//
        cell.favTweet(tweetArr[indexPath.row]["favorited"] as! Bool)
        cell.tweetID = tweetArr[indexPath.row]["id"] as! Int
        cell.reTweet = tweetArr[indexPath.row]["retweeted"] as! Bool
        // retweetCount, favCount
        let oldRCount = cell.reTweetCount.text
        let oldFCount = cell.favCount.text
        
        print("old val : r = \(String(describing: oldRCount)) f = \(String(describing: oldFCount))")
        cell.reTweetCount.text = (String(describing: tweetArr[indexPath.row]["retweet_count"] as! Int))
        //"\(tweetArr[indexPath.row]["retweet_count"] as! Int))"
        cell.favCount.text = (String(describing: tweetArr[indexPath.row]["favorite_count"] as! Int))
        if(oldRCount != cell.reTweetCount.text || oldFCount != cell.favCount.text){
            //tableView.reloadData()
               print("new val : r = \(String(describing: cell.reTweetCount)) f = \(String(describing: cell.favCount))")
        }
        return cell
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (failedToLoad){
            print("staticNum " ,staticNum)
            //return staticNum
            //need to debug, doesn't work when fav is used
            return tweetArr.count
        }
        else{
            return tweetArr.count
        }
    }
    //------------------------alert to show that Tweets couldn't be loaded-------------
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
    }
    
}
