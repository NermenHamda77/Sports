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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: "favCell")
        tableView.delegate = self
        tableView.dataSource = self

        // Start the notifier once in viewDidLoad
        startReachabilityNotifier()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability.stopNotifier()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startReachabilityNotifier()
    }

    func startReachabilityNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavTableViewCell

        cell.favLeagueImage.layer.cornerRadius = 30.0
        cell.favLeagueImage.layer.masksToBounds = true
        

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        // Animate cell selection
        UIView.animate(withDuration: 0.2, animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
                cell?.transform = CGAffineTransform.identity
            }) { (completed) in
                // Check reachability after the animation
                self.checkReachability { isReachable in
                    if isReachable {
                        self.goToSecondViewController()
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

        // Immediately check the current connection status
        if reachability.connection != .unavailable {
            completion(true)
        } else {
            completion(false)
        }
    }

    func goToSecondViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "secondvc") as? SecondViewController {
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }

    func showAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
