//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Beverly Abadines on 1/27/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    var movie : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        sumLabel.text = movie["overview"] as?String
        sumLabel.sizeToFit()
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        
        //posterPath + baseUrl = special type of URL (has valid form of "https")
        let posterUrl = URL(string: baseUrl + posterPath)
        
        //gets img from url
        //modify image = aspect fill and clip to bounds
        posterView.af_setImage(withURL: posterUrl!)
        
        let backgroundBaseUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: backgroundBaseUrl + backdropPath)
        backdropView.af_setImage(withURL: backdropURL!)
    }
   

}
