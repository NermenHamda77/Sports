//
//  TeamDetails.swift
//  SportsApp
//
//  Created by Ner Meen on 24/05/2024.
//

import Foundation


struct TeamDetailsResult: Decodable {
    let success: Int?
    let result: [TeamDetailsItem]?
}


struct TeamDetailsItem: Decodable {
    let team_name: String?
    let team_logo: String?
    let team_key: Int?
    let players: [Player]?
    let coaches: [Coach]?

}


struct Coach: Decodable {
    let coach_name: String?

}


struct Player: Decodable {
    let player_name, player_number, player_type: String?
    let player_age, player_match_played, player_goals, player_yellow_cards: String?
    let player_red_cards: String?
    let player_image: String?
}
