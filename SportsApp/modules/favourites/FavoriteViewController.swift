//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by Ner Meen on 23/05/2024.
//

import UIKit

class FavoriteViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var tableView: UITableView!
    
  

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: "favCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavTableViewCell
        
        cell.favLeagueImage.layer.cornerRadius = 30.0
        cell.favLeagueImage.layer.masksToBounds = true
        
        cell.favView.layer.cornerRadius = 35.0
        cell.favView.layer.masksToBounds = true
        cell.favView.layer.borderWidth = 1.0
        cell.favView.layer.borderColor = UIColor.blue.cgColor
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
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
