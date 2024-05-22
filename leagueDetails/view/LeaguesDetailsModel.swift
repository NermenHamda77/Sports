//
//  LeaguesDetailsModel.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 20/05/2024.
//

import Foundation

struct UpcomingMatchesResultForFootballBasketballCricket: Decodable {
    let success: Int?
    let result: [UpcomingMatchesForFootballBasketballCricketItem]?
}


struct UpcomingMatchesForFootballBasketballCricketItem: Decodable {
    let event_date, event_time, event_home_team, event_away_team, home_team_logo, away_team_logo: String?
    }


// MARK: League Details -> Upcoming (for a certain sport (Tennis only) )

struct UpcomingMatchesResultForTennis: Decodable {
    let success: Int?
    let result: [UpcomingMatchesForTennisItem]?
}


struct UpcomingMatchesForTennisItem: Decodable {
    let event_date, event_time, event_first_player, event_second_player, event_first_player_logo, event_second_player_logo: String?
}

// MARK: League Details -> Latest Results / Live Matches (for a certain sport (Football/Basketball/Cricket only) )

struct LiveMatchesResultForFootballBasketballCricket: Decodable {
    let success: Int?
    let result: [LiveMatchesForFootballBasketballCricketItem]?
}


struct LiveMatchesForFootballBasketballCricketItem: Decodable {
    let event_home_team, event_away_team, event_final_result, home_team_logo, away_team_logo: String?
    let event_date, event_time: String?
}


// MARK: League Details -> Latest Results / Live Matches (for a certain sport (Tennis only) )

struct LiveMatchesResultForTennis: Decodable {
    let success: Int?
    let result: [LiveMatchesForTennisItem]?
}


struct LiveMatchesForTennisItem: Decodable {
    let event_first_player, event_second_player, event_final_result, event_first_player_logo, event_second_player_logo: String?
    let event_date, event_time: String?
}

// MARK: League Details -> Teams (for a certain sport (Football/Basketball/Cricket only) )

struct AllTeamsResult: Decodable {
    let success: Int?
    let result: [AllTeamsItem]?
}

struct AllTeamsItem: Decodable {
    let team_key: Int?
    let team_logo: String?

}


// MARK: League Details -> Players (for a certain sport (Tennis only) )

struct AllPlayersResult: Decodable {
    let success: Int?
    let result: [AllPlayersItem]?
}

struct AllPlayersItem: Decodable {
    let player_key: Int?
    let player_image: String?
}
