//
//  TweetCell.swift
//  Twitter
//
//  Created by Beverly Abadines on 2/5/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var tweetID : Int = -1
    var favorited: Bool = false
    var reTweet : Bool = false
    
    var tweet:TweetCell!{
        didSet{
            profileImg = tweet.profileImg
            userName.text = tweet.userName.text
            tweetText.text = tweet.tweetText.text
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
            print("hey")
        }
    }
 
    func reTweet(_ isReTweet:Bool) {
        reTweet =  isReTweet
        if(reTweet){
            favButton.setImage(UIImage(named:"swap_vert_black_54x54"), for: UIControlState.normal)
        } else{
            favButton.setImage(UIImage(named:"swap_vert_circle_54x54"), for: UIControlState.normal)
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
    }
    
    
}
