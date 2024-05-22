//
//  TeamTableViewController.swift
//  SportsApp
//
//  Created by Ner Meen on 21/05/2024.
//

import UIKit

class TeamTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register the custom cells
        tableView.register(UINib(nibName: "TopTeamTableViewCell", bundle: nil), forCellReuseIdentifier: "topCell")
        tableView.register(UINib(nibName: "MiddleTableViewCell", bundle: nil), forCellReuseIdentifier: "middleCell")
        tableView.register(UINib(nibName: "CollectionPlayersTableViewCell", bundle: nil), forCellReuseIdentifier: "playersCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "topCell", for: indexPath) as! TopTeamTableViewCell
            // Configure cell (set images and label text)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "middleCell", for: indexPath) as! MiddleTableViewCell
            // Configure footer labels
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playersCell", for: indexPath) as! CollectionPlayersTableViewCell
            // No need to set delegate and dataSource here, as it's done in the CollectionPlayersTableViewCell class
            return cell
        }
    }
}

