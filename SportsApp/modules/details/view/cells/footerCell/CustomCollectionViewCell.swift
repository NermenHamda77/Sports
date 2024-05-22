//
//  CustomCollectionViewCell.swift
//  SportsApp
//
//  Created by Ner Meen on 21/05/2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
