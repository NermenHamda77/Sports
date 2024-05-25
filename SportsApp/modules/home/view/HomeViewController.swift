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
        Sports(image: "football.jpeg", title: "Football"),
        Sports(image: "basketball.jpeg", title: "Basketball"),
        Sports(image: "tennis.jpeg", title: "Tennis"),
        Sports(image: "cricket.jpg", title: "Cricket"),
    ]
    
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
        checkReachability { isReachable in
            if isReachable {
                self.goToThirdViewController()
            } else {
                self.showAlert()
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

    func goToThirdViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let thirdVC = storyboard.instantiateViewController(withIdentifier: "thirdvc") as? ThirdViewController {
            navigationController?.pushViewController(thirdVC, animated: true)
        }
    }

    func showAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
