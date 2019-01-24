//
//  DetailViewController.swift
//  Tumblr
//
//  Created by Beverly Abadines on 1/23/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImg: UIImageView!
    
    var imagePassed : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImg.image = imagePassed
        }
}
