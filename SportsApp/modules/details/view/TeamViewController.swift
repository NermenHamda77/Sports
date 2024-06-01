//
//  TeamViewController.swift
//  SportsApp
//
//  Created by Ner Meen on 22/05/2024.
//

import UIKit
import Kingfisher

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var sportImage: UIImageView!
    var indicator: UIActivityIndicatorView?
    var sportName: String?
    var teamId: String?
    
    let viewModel = TeamViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = UIActivityIndicatorView(style: .medium)
        indicator?.center = view.center
        view.addSubview(indicator!)
        indicator?.startAnimating()
                
        let nib = UINib(nibName: "PlayersTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "playersCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
       
        sportImage.alpha = 0.9
        
       
        viewModel.updateUI = { [weak self] in
                    DispatchQueue.main.async {
                        self?.updateUI()
                        self?.indicator?.stopAnimating()
                        self?.indicator?.removeFromSuperview()
                    }
        }
        
        // Fetch team details
        if let sportName = sportName, let teamId = teamId {
                   viewModel.fetchTeamDetails(sportName: sportName, teamId: teamId)
               }
    }
    
    func updateUI() {
        teamName.text = viewModel.teamName
        coachName.text = viewModel.coachName
        
        if let url = viewModel.teamImageURL {
            teamImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            teamImage.layer.cornerRadius = 50.0
            teamImage.layer.masksToBounds = true
        }
        
        // Set sportImage based on backgroundImage
        switch sportName {
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
            cell.playerImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        } else {
            cell.playerImage.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}
