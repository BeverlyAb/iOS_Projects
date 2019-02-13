//
//  TweetCell.swift
//  Twitter
//
//  Created by Beverly Abadines on 2/5/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var reTweetCount: UILabel!
    
    
    var tweetID : Int = -1
    var favorited: Bool = false
    var reTweet : Bool = false
    
    var tweet:TweetCell!{
        didSet{
            profileImg = tweet.profileImg
            userName.text = tweet.userName.text
            tweetText.text = tweet.tweetText.text
            reTweetCount.text = tweet.reTweetCount.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //button navigation

    func favTweet(_ isFav:Bool){
        favorited =  isFav
        if(favorited){
            favButton.setImage(UIImage(named:"favorite_black_54x54"), for: UIControlState.normal)
        } else{
            favButton.setImage(UIImage(named:"favorite_outline_black_54x54"), for: UIControlState.normal)
        }
    }
 
    func reTweet(_ isReTweet:Bool) {
        reTweet =  isReTweet
        if(reTweet){
            retweetButton.setImage(UIImage(named:"swap_vert_black_54x54"), for: UIControlState.normal)
            print("hoy\n")
        } else{
            retweetButton.setImage(UIImage(named:"swap_vertical_circle_black_54x54"), for: UIControlState.normal)
        }
    }

    //toggle button display
    @IBAction func favDisplay(_ sender: Any) {
        let fav = !favorited
        if(fav){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.favTweet(true)
            }, failure: { (error) in
                print("Favorited failed \(error)")
            })
        } else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                    self.favTweet(false)
                }, failure: { (error) in
                    print("Unfavorited failed \(error)")
                })
        }
    }
    
    @IBAction func reTweetDisplay(_ sender: Any) {
        let reTweety = !reTweet
        if(reTweety){
           
           TwitterAPICaller.client?.retweetTweet(tweetID: tweetID, success: {
              self.reTweet(true)
            }, failure: { (error) in
                print("Retweet failed \(error)")
                print("Fail ID \(self.tweetID)")
            }) 
        } else{
            self.reTweet(false)
            TwitterAPICaller.client?.untweetTweet(tweetID: tweetID, success: {
             
            }, failure: { (error) in
                print("Un-retweet failed \(error)")
            })
        }
    }
    
}
