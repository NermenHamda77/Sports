//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 20/05/2024.
//

import Foundation


class LeaguesDetailsViewModel{
    
    var sportType: String?
    var leagueId: Int?
    
    var bindUpComingEventsToLeagueDetailsViewController : (() ->()) = {}
    var bindLatestResultsToLeagueDetailsViewController : (() ->()) = {}
    var bindTeamsToLeagueDetailsViewController : (() ->()) = {}
    
    var upComingEvents : [UpcomingMatchesItem]!{
        didSet{
            bindUpComingEventsToLeagueDetailsViewController()
        }
    }
    var latestResults : LiveMatchesResult!{
        didSet{
            bindLatestResultsToLeagueDetailsViewController()
        }
    }
    var teams : AllTeamsResult!{
        didSet{
            bindTeamsToLeagueDetailsViewController()
        }
    }
    
    //let network = NetworkService()
    
    // UpComing Events Result
    func getUpComingEvents(sportType: String, leagueId: Int) {
        NetworkService.fetchFixturesResult(sport: sportType, leagueId: leagueId) { [weak self] (data) in
               guard let self = self else { return }
               guard let result = data else {
                   print("No upcoming events data received.")
                   return
               }
               //print("Upcoming events data received: \(result)")
               self.upComingEvents = result.result
           }
       }
     
    // Latest Result
    func getLatestResult(sportType : String , leagueId : Int){
        NetworkService.fetchLiveScoreResult(sport: sportType, leagueId: leagueId){(data) in
            guard let result = data else {return}
            //print("Upcoming events data received: \(result)")
            self.latestResults = result
        }
    }
    
    // Teams
    func getTeams(sportType : String , leagueId : Int){
        NetworkService.fetchTeamsResult(sport: sportType, leagueId: leagueId){(data) in
            guard let result = data else {return}
            //print("Upcoming events data received: \(result)")
            self.teams = result
        }
    }
     
}
