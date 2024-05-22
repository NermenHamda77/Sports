//
//  CollectionPlayersTableViewCell.swift
//  SportsApp
//
//  Created by Ner Meen on 21/05/2024.
//
import UIKit

class CollectionPlayersTableViewCell: UITableViewCell {

    @IBOutlet weak var playersCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Register the collection view cell class
        playersCollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        // Set data source for the collection view
        playersCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource

extension CollectionPlayersTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Or the number of items you want to display
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        // Configure the cell here
        return cell
    }
}
