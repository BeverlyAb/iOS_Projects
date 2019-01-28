//
//  GridDetatilsViewController.swift
//  Flix
//
//  Created by Beverly Abadines on 1/27/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import AlamofireImage

class GridDetatilsViewController: UIViewController {

    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var releaseDate: UILabel!
    var movie : [String:Any]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        sumLabel.text = movie["overview"] as?String
        sumLabel.sizeToFit()
        //enable scrollable text
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: sumLabel.bottomAnchor).isActive = true
        
        
        releaseDate.text = movie["release_date"] as? String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        let posterUrl = URL(string: baseUrl + posterPath)
      
        posterView.af_setImage(withURL: posterUrl!)
        
        let backgroundBaseUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: backgroundBaseUrl + backdropPath)
        backdropView.af_setImage(withURL: backdropURL!)
    }
}
