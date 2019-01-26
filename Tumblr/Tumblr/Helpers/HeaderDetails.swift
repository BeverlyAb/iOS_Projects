//
//  HeaderDetails.swift
//  Tumblr
//
//  Created by Beverly Abadines on 1/25/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//
//an effort to call the function and clean up code
import Foundation
import UIKit

struct HeaderDetails {

    func profile(_ tableView: UITableView, viewForHeaderInSection section: Int, posts:[[String:Any]]) -> UIView? {
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
