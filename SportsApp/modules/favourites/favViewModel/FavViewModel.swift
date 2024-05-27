//
//  FavViewModel.swift
//  SportsApp
//
//  Created by Ner Meen on 26/05/2024.
//

import Foundation

class FavViewModel {
    private var favoriteLeagues: [FavoriteLeagues] = []
    var bindFavoriteLeaguesToController: (() -> Void)?

    func fetchFavoriteLeagues() {
        favoriteLeagues = DatabaseManager.shared.getFavoriteLeagues()
        bindFavoriteLeaguesToController?()
    }

    func numberOfFavoriteLeagues() -> Int {
        return favoriteLeagues.count
    }

    func getFavoriteLeague(at index: Int) -> FavoriteLeagues {
        return favoriteLeagues[index]
    }

    func deleteFavoriteLeague(at index: Int) {
        let league = favoriteLeagues[index]
        DatabaseManager.shared.deleteFavLeague(leagueKey: league.leagueKey)
        favoriteLeagues.remove(at: index)
        bindFavoriteLeaguesToController?()
    }
}
