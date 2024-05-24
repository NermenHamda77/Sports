//
//  TeamViewModel.swift
//  SportsApp
//
//  Created by Ner Meen on 24/05/2024.
//

import Foundation
import UIKit


class TeamViewModel {
    var teamDetails: TeamDetailsResult? {
        didSet {
            self.updateUI?()
        }
    }
    
    var updateUI: (() -> Void)?
    
    func fetchTeamDetails(sportName: String, teamId: String) {
        fetchTeam(sportName: sportName, teamId: teamId) { [weak self] teamDetails in
            self?.teamDetails = teamDetails
        }
    }
    
    var teamName: String {
        return teamDetails?.result?.first?.team_name ?? "No Available Data"
    }
    
    var coachName: String {
        if let coaches = teamDetails?.result?.first?.coaches, !coaches.isEmpty {
            return coaches.first?.coach_name ?? "No Available Data"
        }
        return "No Available Data"
    }
    
    var teamImageURL: URL? {
        guard let urlString = teamDetails?.result?.first?.team_logo else { return nil }
        return URL(string: urlString)
    }
    
    var players: [Player] {
        if let players = teamDetails?.result?.first?.players, !players.isEmpty {
            return players
        } else {
            return [Player(player_name: "No Available Data", player_number: nil, player_type: nil, player_age: nil, player_match_played: nil, player_goals: nil, player_yellow_cards: nil, player_red_cards: nil, player_image: nil)]
        }
    }
}
