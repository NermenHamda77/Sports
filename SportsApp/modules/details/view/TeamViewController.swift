//
//  TeamViewController.swift
//  SportsApp
//
//  Created by Ner Meen on 22/05/2024.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var sportImage: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // to reduce opacity
        sportImage.alpha = 0.9


        let nib = UINib(nibName: "PlayersTableViewCell", bundle: nil)
               tableView.register(nib, forCellReuseIdentifier: "playersCell")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersCell", for: indexPath) as! PlayersTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
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

/*
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

 */
