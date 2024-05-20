//
//  LeagueViewController.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import UIKit

class LeagueViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var leagueTableView: UITableView!
    private var leaguesViewModel = LeaguesViewModel()

    
    @IBAction func youtube(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesViewModel.leaguesResult.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.layer.cornerRadius = 6.0
        cell.layer.masksToBounds = true
        
        cell.myLogo.layer.cornerRadius = 35.0
        cell.myLogo.layer.masksToBounds = true
        
        let league = leaguesViewModel.leaguesResult[indexPath.row]
        cell.leagueName.text = league.leagueName
                
        if let logoUrlString = league.leagueLogo, let logoUrl = URL(string: logoUrlString) {
                    cell.myLogo.loadImage(from: logoUrl)
                } else {
                    cell.myLogo.image = UIImage(named: "t")
                }
                
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        
                    
        leaguesViewModel.bindResultToLeagueViewController = { [weak self] in
                    DispatchQueue.main.async {
                        self?.leagueTableView.reloadData()
                    }
                }
                
                leaguesViewModel.getLeaguesResult(sportType: "football")
    }
    

}

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
