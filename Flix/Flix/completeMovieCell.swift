//
//  completeMovieCell.swift
//  Flix
//
//  Created by Beverly Abadines on 1/20/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class completeMovieCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
