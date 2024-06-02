//
//  HomeCollectionViewCell.swift
//  SportsApp
//
//  Created by Ner Meen on 20/05/2024.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    
    // Add an overlay view programmatically if not done in the xib
    var overlayView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialize the overlay view
        overlayView = UIView(frame: sportImage.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Adjust alpha as needed
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // To resize with image view
        sportImage.addSubview(overlayView)
    }
}
