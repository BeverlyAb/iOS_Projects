//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Beverly Abadines on 1/27/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var movie : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(movie["title"])
    }
   

}
