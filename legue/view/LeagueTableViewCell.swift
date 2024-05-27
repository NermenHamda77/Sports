//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var myLogo: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
