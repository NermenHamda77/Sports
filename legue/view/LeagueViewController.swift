//
//  LeagueViewController.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import UIKit

class LeagueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var indicator: UIActivityIndicatorView?
    
    @IBAction func addFavorite(_ sender: UIButton) {
        guard let indexPath = getCurrentIndexPath(for: sender) else { return }

        let isFavorite = leaguesViewModel.isLeagueFavorite(at: indexPath.row)

        if isFavorite {
            leaguesViewModel.removeLeagueFromFavorites(at: indexPath.row)
        } else {
            leaguesViewModel.addLeagueToFavorites(at: indexPath.row)
        }

        leagueTableView.reloadRows(at: [indexPath], with: .automatic)

        // Print all stored favorite leagues
        let favoriteLeagues = DatabaseManager.shared.getFavoriteLeagues()
        for league in favoriteLeagues {
            print("--------------------------------------------")
            print("League Name: \(league.leagueName), League Key: \(league.leagueKey), League Logo: \(league.leagueLogo), Sport Name: \(league.sportName)")
        }
    }

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

        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(addFavorite(_:)), for: .touchUpInside)

        // Set the button image based on whether the league is a favorite
        if leaguesViewModel.isLeagueFavorite(at: indexPath.row) {
            cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.favoriteButton.tintColor = .red
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.favoriteButton.tintColor = .gray
        }

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = UIActivityIndicatorView(style: .medium)
        indicator?.center = view.center
        view.addSubview(indicator!)
        indicator?.startAnimating()
        
        leagueTableView.delegate = self
        leagueTableView.dataSource = self

        if let chosenSportName = chosenSportName {
            print("Chosen Sport: \(chosenSportName)")
            leaguesViewModel.selectedSportType = chosenSportName
        }

        leaguesViewModel.bindResultToLeagueViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.leagueTableView.reloadData()
                self?.indicator?.stopAnimating()
                self?.indicator?.removeFromSuperview()
            }
        }

        leaguesViewModel.getLeaguesResult(sportType: chosenSportName ?? "football")
    }

    private func getCurrentIndexPath(for button: UIButton) -> IndexPath? {
        let buttonPosition = button.convert(CGPoint.zero, to: leagueTableView)
        return leagueTableView.indexPathForRow(at: buttonPosition)
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
