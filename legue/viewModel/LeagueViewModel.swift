//
//  LeagueViewModel.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import Foundation

class LeaguesViewModel{
    var bindResultToLeagueViewController : (() ->()) = {}
    var leaguesResult : Leagues!{
        didSet{
            bindResultToLeagueViewController()
        }
    }
    func getLeaguesResult(sportType : String){
        NetworkService().fetchLeaguesResult(sport: sportType){(data) in
            guard let result = data else {return}
            self.leaguesResult = result
        }
    }
}
