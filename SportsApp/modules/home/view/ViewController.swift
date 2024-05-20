//
//  ViewController.swift
//  SportsApp
//
//  Created by Ner Meen on 18/05/2024.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var sports: [String] = ["Football","BasketBall","Tennis","Fighting"]
   
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell

        cell.sportName.text = sports[indexPath.row]
        cell.sportImage.image = UIImage(named: "Arther.jpeg")
        cell.sportImage.layer.cornerRadius = 6.0
        cell.sportImage.layer.masksToBounds = true
        return cell
    }

}

