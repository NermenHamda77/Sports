//
//  LeagueDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 21/05/2024.
//

import UIKit


class LeagueDetailsCollectionViewController: UICollectionViewController {
    
    var viewModel = LeaguesDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
                 switch sectionIndex {
                 case 0:
                     return self.drawTheTopSection()
                 case 1:
                     return self.drawTheLatestResultsSection()
                 case 2:
                     return self.drawTeamsSection()
                 default:
                     fatalError("Unexpected section")
                 }
             }
        
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        viewModel.bindUpComingEventsToLeagueDetailsViewController = { [weak self] in
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
        
        viewModel.bindLatestResultsToLeagueDetailsViewController = {
            [weak self] in DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.bindTeamsToLeagueDetailsViewController = {
            [weak self] in DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        /*
        // Fetch data using the updated viewModel properties
       viewModel.getUpComingEvents(sportType: viewModel.sportType ?? "", leagueId: viewModel.leagueId ?? 0)
       viewModel.getLatestResult(sportType: viewModel.sportType ?? "", leagueId: viewModel.leagueId ?? 0)
      viewModel.getTeams(sportType: viewModel.sportType ?? "", leagueId: viewModel.leagueId ?? 0)*/
        
    viewModel.getUpComingEvents(sportType: "football", leagueId: 207)
    viewModel.getLatestResult(sportType: "football", leagueId: 207)
    viewModel.getTeams(sportType: "football", leagueId: 207)
        
        
}

    func drawTheTopSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8,leading: 16 , bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    func drawTheLatestResultsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    func drawTeamsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.upComingEvents?.count ?? 0
        case 1:
           // print(viewModel.latestResults?.result?.count ?? 0)
            return viewModel.latestResults?.result?.count ?? 0
        case 2:
            print(viewModel.teams?.result?.count)
            return viewModel.teams?.result?.count ?? 0
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as! UpComingEventCollectionViewCell
            configureUpcomingEventCell(cell, at: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResultCell", for: indexPath) as! LastedCollectionViewCell
            configureLatestResultCell(cell, at: indexPath)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
            configureTeamsCell(cell, at: indexPath)
            return cell
        default:
            fatalError("Unexpected section")
        }
    }

    private func configureUpcomingEventCell(_ cell: UpComingEventCollectionViewCell, at indexPath: IndexPath) {
        // Your existing cell configuration code for upcoming events
        if let fixture = viewModel.upComingEvents?[indexPath.row] {
            
            cell.teamOneName.text = fixture.event_home_team
            cell.teamTwoName.text = fixture.event_away_team

            if let homeTeamLogoUrlString = fixture.home_team_logo, let awayTeamLogoUrlString = fixture.away_team_logo {
                if let homeTeamLogoUrl = URL(string: homeTeamLogoUrlString), let awayTeamLogoUrl = URL(string: awayTeamLogoUrlString) {
                    cell.teamOneLogo.loadImageUp(from: homeTeamLogoUrl)
                    cell.teamTwoLogo.loadImageUp(from: awayTeamLogoUrl)
                }
            }
            //add border
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.cornerRadius = 8.0

        }
    }

    private func configureLatestResultCell(_ cell: LastedCollectionViewCell, at indexPath: IndexPath) {
        // Your cell configuration code for latest results
        if let latestResult = viewModel.latestResults?.result?[indexPath.item] {
            
            cell.teamOneName.text = latestResult.event_home_team
            print(cell.teamOneName.text)
            cell.teamTwoName.text = latestResult.event_away_team
            cell.score.text = latestResult.event_final_result
            
            
            if let homeTeamLogoUrlString = latestResult.home_team_logo, let awayTeamLogoUrlString = latestResult.away_team_logo {
                if let homeTeamLogoUrl = URL(string: homeTeamLogoUrlString), let awayTeamLogoUrl = URL(string: awayTeamLogoUrlString) {
                    cell.teamOneLogo.loadImageUp(from: homeTeamLogoUrl)
                    cell.teamTwoLogo.loadImageUp(from: awayTeamLogoUrl)
                }
            }
            //add border
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.cornerRadius = 8.0

        }
    }
    
    private func configureTeamsCell(_ cell: TeamsCollectionViewCell, at indexPath: IndexPath) {
        
        if let  teams = viewModel.teams?.result?[indexPath.item] {
            
          cell.teamName.text = teams.team_name
          print(cell.teamName.text)
            
          if let homeTeamLogoUrlString = teams.team_logo{
                if let homeTeamLogoUrl = URL(string: homeTeamLogoUrlString), let awayTeamLogoUrl = URL(string: homeTeamLogoUrlString) {
                    cell.teamLogo.loadImageUp(from: homeTeamLogoUrl)
                }
            }
            //add border
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.cornerRadius = 8.0

        }
    }


    // MARK: UICollectionViewDelegate
}


extension UIImageView {
    func loadImageUp(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
