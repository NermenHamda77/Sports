//
//  LeaguesDetailsModel.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 20/05/2024.
//

import Foundation

struct UpcomingMatchesResult: Decodable {
    let success: Int?
    let result: [UpcomingMatchesItem]?
}


struct UpcomingMatchesItem: Decodable {
    let event_date, event_time, event_home_team, event_away_team, home_team_logo, away_team_logo: String?
    }

// MARK: League Details -> Latest Results / Live Matches (for a certain sport (Football/Basketball/Cricket/tennis) )

struct LiveMatchesResult: Decodable {
    let success: Int?
    let result: [LiveMatchesItem]?
}


struct LiveMatchesItem: Decodable {
    let event_home_team, event_away_team, event_final_result, home_team_logo, away_team_logo: String?
    let event_date, event_time: String?
}
// MARK: League Details -> Teams (for a certain sport (Football/Basketball/Cricket/tennis) )

struct AllTeamsResult: Decodable {
    let success: Int?
    let result: [AllTeamsItem]?
}

struct AllTeamsItem: Decodable {
    let team_key: Int?
    let team_logo: String?
    let team_name: String?

}

