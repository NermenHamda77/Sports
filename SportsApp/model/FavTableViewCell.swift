//
//  FavTableViewCell.swift
//  SportsApp
//
//  Created by Ner Meen on 23/05/2024.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    
    @IBOutlet weak var favLeagueName: UILabel!
    @IBOutlet weak var favLeagueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
