//
//  LeagueDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 21/05/2024.
//

import UIKit

class LeagueDetailsCollectionViewController: UICollectionViewController {
    
    var sportName: String?
    var leagueId: Int?
    var indicator: UIActivityIndicatorView?
    var viewModel = LeaguesDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize and configure the activity indicator
        indicator = UIActivityIndicatorView(style: .medium)
        indicator?.center = view.center
        view.addSubview(indicator!)
        
        // Start the activity indicator before fetching data
        indicator?.startAnimating()
        
        // Register the header view
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        // Set up the section headers
        let upcomingEventsHeader = createSectionHeader(size: .absolute(20))
        let latestResultsHeader = createSectionHeader(size: .absolute(44))
        let teamsHeader = createSectionHeader(size: .absolute(44))
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return self.drawTheTopSection(withHeader: upcomingEventsHeader)
            case 1:
                return self.drawTheLatestResultsSection(withHeader: latestResultsHeader)
            case 2:
                return self.drawTeamsSection(withHeader: teamsHeader)
            default:
                fatalError("Unexpected section")
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        // Bind data to reload collection view and stop the activity indicator
        viewModel.bindUpComingEventsToLeagueDetailsViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.indicator?.stopAnimating()
                self?.indicator?.removeFromSuperview()
            }
        }
        
        viewModel.bindLatestResultsToLeagueDetailsViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.indicator?.stopAnimating()
                self?.indicator?.removeFromSuperview()
            }
        }
        
        viewModel.bindTeamsToLeagueDetailsViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.indicator?.stopAnimating()
                self?.indicator?.removeFromSuperview()
            }
        }
        
        if let sportName = sportName, let leagueId = leagueId {
            viewModel.getUpComingEvents(sportType: sportName, leagueId: leagueId)
            viewModel.getLatestResult(sportType: sportName, leagueId: leagueId)
            viewModel.getTeams(sportType: sportName, leagueId: leagueId)
        }
    }

    func drawTheTopSection(withHeader header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8,leading: 16 , bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
    
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func drawTheLatestResultsSection(withHeader header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.97), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [header]
        return section
    }

    
    func drawTeamsSection(withHeader header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.55), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createSectionHeader(size: NSCollectionLayoutDimension) -> NSCollectionLayoutBoundarySupplementaryItem {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: size)
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            return sectionHeader
        }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            guard kind == UICollectionView.elementKindSectionHeader else {
                fatalError("Unexpected element kind")
            }
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
            
            switch indexPath.section {
            case 0:
                headerView.textLabel.text = "Upcoming Events"
            case 1:
                headerView.textLabel.text = "Latest Results"
            case 2:
                headerView.textLabel.text = "Teams"
            default:
                fatalError("Unexpected section")
            }
            
            return headerView
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
            if viewModel.upComingEvents == nil{
                return 8
            }else{
                viewModel.upComingEvents.count
            }
            return viewModel.upComingEvents?.count ?? 0
        case 1:
            if viewModel.latestResults == nil || viewModel.latestResults?.result?.isEmpty ?? true {
                        return 8
        } else {
            return min(viewModel.latestResults!.result!.count, 20)
            }
        case 2:
            if viewModel.teams == nil || viewModel.teams?.result?.isEmpty ?? true {
                return 8
            }else{
                return viewModel.teams!.result!.count
            }
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
        if let fixture = viewModel.upComingEvents?[indexPath.row] {
            
            cell.teamOneName.text = fixture.event_home_team
            cell.teamTwoName.text = fixture.event_away_team
            cell.upComingDate.text = fixture.event_date

            if let homeTeamLogoUrlString = fixture.home_team_logo, let awayTeamLogoUrlString = fixture.away_team_logo {
                if let homeTeamLogoUrl = URL(string: homeTeamLogoUrlString), let awayTeamLogoUrl = URL(string: awayTeamLogoUrlString) {
                    cell.teamOneLogo.loadImageUp(from: homeTeamLogoUrl)
                    cell.teamTwoLogo.loadImageUp(from: awayTeamLogoUrl)
                }
            }
            // Add border
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.cornerRadius = 8.0
        } else {
            cell.teamOneName.text = "No Data"
            cell.teamTwoName.text = "No Data"
            cell.upComingDate.text = "!!"
            cell.teamOneLogo.image = UIImage(named: "defultImage")
            cell.teamTwoLogo.image = UIImage(named: "defultImage")
        }
        // Add border
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 8.0
        
        // Add shadow
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
        
        // Set background image
    let backgroundImage = UIImage(named: "background7")
    cell.backgroundColor = UIColor(patternImage: backgroundImage!)
        
    }


    private func configureLatestResultCell(_ cell: LastedCollectionViewCell, at indexPath: IndexPath) {
        if let latestResult = viewModel.latestResults?.result?[indexPath.item] {
            
            cell.teamOneName.text = latestResult.event_home_team
            cell.teamTwoName.text = latestResult.event_away_team
            cell.score.text = latestResult.event_final_result
            cell.lastedDate.text = latestResult.event_date
            
            if let homeTeamLogoUrlString = latestResult.home_team_logo, let awayTeamLogoUrlString = latestResult.away_team_logo {
                if let homeTeamLogoUrl = URL(string: homeTeamLogoUrlString), let awayTeamLogoUrl = URL(string: awayTeamLogoUrlString) {
                    cell.teamOneLogo.loadImageUp(from: homeTeamLogoUrl)
                    cell.teamTwoLogo.loadImageUp(from: awayTeamLogoUrl)
                }
            }
        } else {
            cell.teamOneName.text = "OOp! No Data"
            cell.teamTwoName.text = "OOP! No Data"
            cell.score.text = "!!"
            cell.lastedDate.text = "!!"
            cell.teamOneLogo.image = UIImage(named: "defultImage")
            cell.teamTwoLogo.image = UIImage(named: "defultImage")
        }
        // Add border
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 8.0
        
        // Add shadow
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
        
    cell.contentView.backgroundColor = .clear
        
    cell.backgroundView = UIImageView(image: UIImage(named: "background7"))
    cell.backgroundView?.contentMode = .scaleAspectFill
    cell.backgroundView?.clipsToBounds = true
    
        
    }
    
    /* nav to TeamViewController */
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.section == 2 {
                guard let team = viewModel.teams?.result?[indexPath.item], let teamId = team.team_key else {
                    return
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let teamVC = storyboard.instantiateViewController(withIdentifier: "teamDetailsvc") as? TeamViewController {
                    teamVC.sportName = sportName
                    teamVC.teamId = String(teamId)
                    navigationController?.pushViewController(teamVC, animated: true)
                }
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
            
            // Add shadow
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 4
            cell.layer.masksToBounds = false
            
            let backgroundImage = UIImage(named: "background7")
            cell.backgroundColor = UIColor(patternImage: backgroundImage!)

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
