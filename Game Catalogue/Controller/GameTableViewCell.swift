//
//  GameTableViewCell.swift
//  Game Catalogue
//
//  Created by Nanda Wawan Kurniawan on 23/12/20.
//  Copyright © 2020 Dicoding Indoneisa. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameReleased: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    @IBOutlet weak var gamePhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
