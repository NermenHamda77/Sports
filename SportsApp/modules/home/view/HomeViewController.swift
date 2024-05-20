//
//  HomeViewController.swift
//  SportsApp
//
//  Created by Ner Meen on 20/05/2024.
//

import UIKit

class HomeViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var sport : [Sports] = [
    Sports(image: "Arther.jpeg", title: "Football"),
    Sports(image: "Arther.jpeg", title: "Basketball"),
    Sports(image: "Arther.jpeg", title: "Tennis"),
    Sports(image: "Arther.jpeg", title: "Cricket"),
    ]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Do any additional setup after loading the view.
    }
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sport.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        cell.sportName.text = sport[indexPath.row].title
        cell.sportImage.image = UIImage(named: sport[indexPath.row].image ?? "")
        cell.sportImage.layer.cornerRadius = 9.0
        cell.sportImage.layer.masksToBounds = true

        return cell
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 370, height: 200)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
