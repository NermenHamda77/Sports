//
//  HomeViewController.swift
//  SportsApp
//
//  Created by Ner Meen on 20/05/2024.
//

import UIKit
import Reachability

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var sport: [Sports] = [
        Sports(image: "football1.jpeg", title: "Football"),
        Sports(image: "basketball1.jpeg", title: "Basketball"),
        Sports(image: "tennis1.jpeg", title: "Tennis"),
        Sports(image: "cricket1.jpg", title: "Cricket"),
    ]

    var chosenSportName: String?

    @IBOutlet weak var collectionView: UICollectionView!
    let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()

        // Start the reachability notifier
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sport.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        cell.sportName.text = sport[indexPath.row].title
        cell.sportImage.image = UIImage(named: sport[indexPath.row].image ?? "")
        cell.sportImage.layer.cornerRadius = 45.0
        cell.sportImage.layer.masksToBounds = true

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)

        // Set the chosenSportName based on the selected cell, and convert it to lowercase
        chosenSportName = sport[indexPath.row].title?.lowercased()

        // Print the chosenSportName to verify
        if let chosenSportName = chosenSportName {
            print(chosenSportName) // This will print the name in lowercase
        }

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
                      self.goToLeagueViewController()
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
    
    

    func goToLeagueViewController() {
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        if let leagueVC = storyboard.instantiateViewController(withIdentifier: "leaguevc") as? LeagueViewController {

            // Pass the chosenSportName to LeagueViewController
            leagueVC.chosenSportName = chosenSportName

             //Pass the chosenSportName to LeagueViewController
           leagueVC.chosenSportName = chosenSportName

            navigationController?.pushViewController(leagueVC, animated: true)
        }
    }

    func showAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
