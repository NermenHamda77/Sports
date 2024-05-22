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

        let layout = UICollectionViewCompositionalLayout{
            sectionIndex,enviroment in
            return self.drawTheTopSection()
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        viewModel.bindUpComingEventsToLeagueDetailsViewController = { [weak self] in
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
        
        viewModel.getUpComingEvents(sportType: "football", leagueId: 1)
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(viewModel.upComingEvents?.result?.count ?? 0)
        return viewModel.upComingEvents?.result?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as! UpComingEventCollectionViewCell
    
        
        // Configure the cell
        cell.layer.cornerRadius = 50 // Adjust the value as needed
        cell.contentView.layer.masksToBounds = true
                
        //border
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
       
        if let fixture = viewModel.upComingEvents?.result?[indexPath.item] {
                    cell.teamOneName.text = fixture.event_home_team
                    cell.teamTwoName.text = fixture.event_away_team

            if let homeTeamLogoUrlString = fixture.home_team_logo, let awayTeamLogoUrlString = fixture.away_team_logo {
                        if let homeTeamLogoUrl = URL(string: homeTeamLogoUrlString), let awayTeamLogoUrl = URL(string: awayTeamLogoUrlString) {
                            cell.teamOneLogo.loadImageUp(from: homeTeamLogoUrl)
                            cell.teamTwoLogo.loadImageUp(from: awayTeamLogoUrl)
                        }
                    }
                }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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
