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

}
