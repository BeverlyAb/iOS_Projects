//
//  Tweet.swift
//  Twitter
//
//  Created by Beverly Abadines on 2/5/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class Tweet{
    var name : String?
    var text: String?
    var img : UIImageView?
    
    init(name : String, text :String, imgURL :String){
        self.name = name
        self.text = text

        img?.af_setImage(withURL: URL(string:imgURL)!)
    }
    
    convenience init(){
    self.init(name : "First Name Last Name", text: "No Tweets Written or Read", imgURL : "https://i.imgur.com/etjgJ2D.jpg")
    }
}
