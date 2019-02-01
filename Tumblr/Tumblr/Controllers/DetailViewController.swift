//
//  DetailViewController.swift
//  Tumblr
//
//  Created by Beverly Abadines on 1/23/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailImg: UIImageView!
    var imagePassed : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.maximumZoomScale = 10
        scrollView.minimumZoomScale = 1
        detailImg.image = imagePassed
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailImg
    }
    
}
