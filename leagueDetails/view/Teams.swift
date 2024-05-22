//
//  Teams.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 20/05/2024.
//

import Foundation

struct Teams: Codable {
    var success: Int?
    var result: [TeamsResult]
}

struct TeamsResult: Codable {
    var team_key: Int?
    var team_name: String?
    var team_logo: String?
    var players: [Player]?
}

struct Player: Codable{
    var player_key : Int
    var player_name: String?
    var player_type: String?
    var player_number: String?
    var player_image: String?
}


// MARK: - TennisPlayer
struct TennisPlayer: Decodable {
    let success: Int
    let result: [TennisPlayerResult]
}

// MARK: - Result
struct TennisPlayerResult: Decodable {
    let playerKey: Int
    let playerName, playerCountry, playerBday: String?
    let playerLogo: String?

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerCountry = "player_country"
        case playerBday = "player_bday"
        case playerLogo = "player_logo"
    }
}
