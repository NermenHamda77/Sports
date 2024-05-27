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
    
    func addLeagueToFavorites(at index: Int) {
        let league = leaguesResult[index]
        let favoriteLeague = FavoriteLeagues(leagueName: league.leagueName,
                                             leagueKey: league.leagueKey,
                                             leagueLogo: league.leagueLogo ?? "",
                                             sportName: selectedSportType ?? "")
        DatabaseManager.shared.insertLeague(league: favoriteLeague)
    }
    
    func removeLeagueFromFavorites(at index: Int) {
        let league = leaguesResult[index]
        DatabaseManager.shared.deleteFavLeague(leagueKey: league.leagueKey)
    }
    
    func isLeagueFavorite(at index: Int) -> Bool {
        let league = leaguesResult[index]
        return DatabaseManager.shared.isLeagueFavorite(leagueKey: league.leagueKey)
    }
}
