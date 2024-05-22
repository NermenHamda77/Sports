//
//  UpComingEventCollectionViewCell.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 21/05/2024.
//

import UIKit

class UpComingEventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamOneLogo: UIImageView!
    
    
    @IBOutlet weak var teamTwoLogo: UIImageView!
    
    
    
    @IBOutlet weak var teamOneName: UILabel!
    
    
    @IBOutlet weak var teamTwoName: UILabel!
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            // Set the fixed size for the image views
            let logoSize = CGSize(width: 80, height: 100)
            teamOneLogo.frame.size = logoSize
            teamTwoLogo.frame.size = logoSize
            
            // Allow labels to adjust their content
            teamOneName.numberOfLines = 0
            teamTwoName.numberOfLines = 0
        }
    }
    
    

