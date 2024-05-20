//
//  HomeTableViewCell.swift
//  SportsApp
//
//  Created by Ner Meen on 18/05/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var sportImage: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
