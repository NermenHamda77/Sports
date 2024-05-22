//
//  PlayersTableViewCell.swift
//  SportsApp
//
//  Created by Ner Meen on 22/05/2024.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
