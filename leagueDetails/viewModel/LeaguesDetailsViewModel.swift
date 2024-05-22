//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 20/05/2024.
//

import Foundation


class LeaguesDetailsViewModel{
    
    var bindUpComingEventsToLeagueDetailsViewController : (() ->()) = {}
    var bindLatestResultsToLeagueDetailsViewController : (() ->()) = {}
    var bindCricketLatestResultsToLeagueDetailsViewController : (() ->()) = {}
    var bindTeamsToLeagueDetailsViewController : (() ->()) = {}
    
    var upComingEvents : UpcomingMatchesResultForFootballBasketballCricket!{
        didSet{
            bindUpComingEventsToLeagueDetailsViewController()
        }
    }
    var latestResults : LiveMatchesResultForFootballBasketballCricket!{
        didSet{
            bindLatestResultsToLeagueDetailsViewController()
        }
    }
    var cricketLatestResults : LiveMatchesResultForFootballBasketballCricket!{
        didSet{
            bindCricketLatestResultsToLeagueDetailsViewController()
        }
    }
    var teams : Teams!{
        didSet{
            bindTeamsToLeagueDetailsViewController()
        }
    }
    
    let network = NetworkService()
    
    // UpComing Events Result
    func getUpComingEvents(sportType: String, leagueId: Int) {
           network.fetchFixturesResult(sport: sportType, leagueId: leagueId) { [weak self] (data) in
               guard let self = self else { return }
               guard let result = data else {
                   print("No upcoming events data received.")
                   return
               }
               print("Upcoming events data received: \(result)")
               self.upComingEvents = result
           }
       }
     
    // Latest Result
    func getLatestResult(sportType : String , leagueId : Int){
        network.fetchLiveScoreResult(sport: sportType, leagueId: leagueId){(data) in
            guard let result = data else {return}
            self.latestResults = result
        }
    }
    /*
    //Cricket latest Result
    func getCricketLatestResult(leagueId : Int){
        network.fetchCricketLivescoreResult(leagueId: leagueId){(data) in
            self.cricketLatestResults = data
        }
    }
    // Teams
    func getTeams(sportType : String , leagueId : Int){
        network.fetchTeamsResult(sport: sportType, leagueId: leagueId){(data) in
//            guard let result = data else {return}
            self.teams = data
        }
    }
     */
}
