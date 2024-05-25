//
//  TeamViewController.swift
//  SportsApp
//
//  Created by Ner Meen on 22/05/2024.
//

import UIKit
import SDWebImage

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var sportImage: UIImageView!
    
    let viewModel = TeamViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up TableView
        let nib = UINib(nibName: "PlayersTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "playersCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set sport image opacity
        sportImage.alpha = 0.9
        
        // Bind to ViewModel
        viewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        
        // Fetch team details
        viewModel.fetchTeamDetails(sportName: "football", teamId: "123")
    }
    
    func updateUI() {
        teamName.text = viewModel.teamName
        coachName.text = viewModel.coachName
        
        if let url = viewModel.teamImageURL {
            teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            teamImage.layer.cornerRadius = 50.0
            teamImage.layer.masksToBounds = true
        }
        
        // Set sportImage based on backgroundImage
        switch viewModel.backgroundImage {
        case "football":
            sportImage.image = UIImage(named: "football.jpg")
        case "basketball":
            sportImage.image = UIImage(named: "basketball.jpg")
        case "cricket":
            sportImage.image = UIImage(named: "cricket.jpg")
        case "tennis":
            sportImage.image = UIImage(named: "tennis.jpg")
        default:
            sportImage.image = UIImage(named: "football.jpg")
        }
        
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersCell", for: indexPath) as! PlayersTableViewCell
        let player = viewModel.players[indexPath.row]
        
        cell.cellView.layer.cornerRadius = 30.0
        cell.cellView.layer.masksToBounds = true
        
        cell.playerImage.layer.cornerRadius = 30.0
        cell.playerImage.layer.masksToBounds = true
        
        cell.cellView.layer.borderWidth = 1.0
        cell.cellView.layer.borderColor = UIColor.black.cgColor
        
        cell.playerName.text = player.player_name
        cell.playerPosition.text = player.player_type ?? "No Available Data"
        cell.playerNumber.text = player.player_number ?? "No Available Data"
        if let imageUrl = URL(string: player.player_image ?? "") {
            cell.playerImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            cell.playerImage.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}
