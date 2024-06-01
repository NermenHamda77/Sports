//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by Ner Meen on 23/05/2024.
//

import UIKit
import Reachability


class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let reachability = try! Reachability()
    private var favViewModel = FavViewModel()
    private var noFavoritesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

       
        noFavoritesLabel = UILabel()
        noFavoritesLabel.text = "No Favorite Leagues"
        noFavoritesLabel.textAlignment = .center
        noFavoritesLabel.textColor = .gray
        noFavoritesLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        noFavoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noFavoritesLabel)

      
        NSLayoutConstraint.activate([
            noFavoritesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noFavoritesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

      
        noFavoritesLabel.isHidden = true

        tableView.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: "favCell")
        tableView.delegate = self
        tableView.dataSource = self

        favViewModel.bindFavoriteLeaguesToController = { [weak self] in
            self?.updateUI()
        }

        startReachabilityNotifier()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability.stopNotifier()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startReachabilityNotifier()
        favViewModel.fetchFavoriteLeagues()
    }

    func startReachabilityNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    func updateUI() {
        tableView.reloadData()
        noFavoritesLabel.isHidden = favViewModel.numberOfFavoriteLeagues() != 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favViewModel.numberOfFavoriteLeagues()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavTableViewCell

        let league = favViewModel.getFavoriteLeague(at: indexPath.row)
        cell.favLeagueName.text = league.leagueName

        
        cell.layer.cornerRadius = 6.0
        cell.layer.masksToBounds = true
        cell.favLeagueImage.layer.cornerRadius = 35.0
        cell.favLeagueImage.layer.masksToBounds = true

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        UIView.animate(withDuration: 0.2, animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
                cell?.transform = CGAffineTransform.identity
            }) { (completed) in
                self.checkReachability { isReachable in
                    if isReachable {
                        self.goToLeagueDetailsViewController(for: indexPath.row)
                    } else {
                        self.showAlert()
                    }
                }
            }
        }
    }

    func checkReachability(completion: @escaping (Bool) -> Void) {
        reachability.whenReachable = { _ in
            completion(true)
        }
        reachability.whenUnreachable = { _ in
            completion(false)
        }

        if reachability.connection != .unavailable {
            completion(true)
        } else {
            completion(false)
        }
    }

    func goToLeagueDetailsViewController(for index: Int) {
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        if let leagueDetailsVC = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsCollectionViewController") as? LeagueDetailsCollectionViewController {
            let selectedLeague = favViewModel.getFavoriteLeague(at: index)
            leagueDetailsVC.sportName = selectedLeague.sportName
            leagueDetailsVC.leagueId = Int(selectedLeague.leagueKey)
            navigationController?.pushViewController(leagueDetailsVC, animated: true)
        }
    }

    func showAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favViewModel.deleteFavoriteLeague(at: indexPath.row)
        }
    }
}


