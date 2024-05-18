//
//  LeagueViewController.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import UIKit

class LeagueViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var leagueTableView: UITableView!
    
    
    @IBAction func youtube(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.layer.cornerRadius = 6.0
        cell.layer.masksToBounds = true
        
        cell.myLogo.layer.cornerRadius = 35.0
        cell.myLogo.layer.masksToBounds = true
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        
    }
    

}
