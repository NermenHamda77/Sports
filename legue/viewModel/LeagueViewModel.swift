//
//  LeagueViewModel.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import Foundation

class LeaguesViewModel {
    
    var selectedSportType: String?
    var selectedLeagueId: Int?

    var bindResultToLeagueViewController: (() -> Void) = {}
    var leaguesResult: [Result] = [] {
        didSet {
            bindResultToLeagueViewController()
        }
    }
    
    func getLeaguesResult(sportType: String) {
        NetworkService().fetchLeaguesResult(sport: sportType) { [weak self] data in
            guard let self = self, let result = data?.result else { return }
            self.leaguesResult = result
        }
    }
}

