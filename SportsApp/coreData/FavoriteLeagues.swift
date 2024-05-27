//
//  FavoriteLeagues.swift
//  SportsApp
//
//  Created by Ner Meen on 26/05/2024.
//

import Foundation

class FavoriteLeagues {
    let leagueName: String
    let leagueKey: Int
    let leagueLogo: String
    let sportName: String
    
    init(leagueName: String, leagueKey: Int, leagueLogo: String, sportName: String) {
        self.leagueName = leagueName
        self.leagueKey = leagueKey
        self.leagueLogo = leagueLogo
        self.sportName = sportName
    }
}
