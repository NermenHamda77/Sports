//
//  LeagueViewController.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import UIKit

class LeagueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var leagueTableView: UITableView!
    var chosenSportName: String? // Variable to receive the chosen sport name
    
    private var leaguesViewModel = LeaguesViewModel()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesViewModel.leaguesResult.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Instantiate the LeagueDetailsCollectionViewController
        guard let leagueDetailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsCollectionViewController") as? LeagueDetailsCollectionViewController else {
            return
        }
        
        // Set the selected sport type and league ID
        let selectedLeague = leaguesViewModel.leaguesResult[indexPath.row]
        leagueDetailsVC.sportName = chosenSportName
        leagueDetailsVC.leagueId = selectedLeague.leagueKey
        
        navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
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
            cell.myLogo.image = UIImage(named: "defultImage")
        }
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      
        leagueTableView.delegate = self
        leagueTableView.dataSource = self

        if let chosenSportName = chosenSportName {
            print("Chosen Sport: \(chosenSportName)")
        }
        
        leaguesViewModel.bindResultToLeagueViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.leagueTableView.reloadData()
            }
        }
        
        leaguesViewModel.getLeaguesResult(sportType: chosenSportName ?? "football")
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
