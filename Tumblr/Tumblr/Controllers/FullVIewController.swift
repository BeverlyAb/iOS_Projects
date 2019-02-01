//
//  FullVIewController.swift
//  Tumblr
//
//  Created by Beverly Abadines on 1/25/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class FullVIewController: UITableViewController{

    @IBOutlet weak var fullImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 10.0
    }

    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return fullImage
    }

}
