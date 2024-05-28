//
//  MockNetworkService.swift
//  SportsAppTests
//
//  Created by Sarah Ahmed on 28/05/2024.
//

import Foundation
@testable import SportsApp

class MokeNetworkServices{
    let mokeLeaguesResponse = "{\"success\":1,\"result\":[{\"league_key\":4,\"league_name\":\"UEFA Europa League\",\"league_logo\":\"\"}]}"

    let mokeFixtureResponse = "{\"success\":1,\"result\":[{\"team_key\":74,\"team_name\":\"Salzburg\",\"team_logo\":\"\",\"players\":[{\"player_key\":554337339,\"player_name\":\"N. Okafor\",\"player_number\":\"77\",\"player_country\":null,\"player_type\":\"Forwards\",\"player_age\":\"22\",\"player_match_played\":\"21\",\"player_goals\":\"7\",\"player_yellow_cards\":\"2\",\"player_red_cards\":\"0\",\"player_image\":\"\"}]}]}"

    let mokeTeamsResponse = "{\"success\":1,\"result\":[{\"team_key\":74,\"team_name\":\"Salzburg\",\"team_logo\":\"\",\"players\":[{\"player_key\":554337339,\"player_name\":\"N. Okafor\",\"player_number\":\"77\",\"player_country\":null,\"player_type\":\"Forwards\",\"player_age\":\"22\",\"player_match_played\":\"21\",\"player_goals\":\"7\",\"player_yellow_cards\":\"2\",\"player_red_cards\":\"0\",\"player_image\":\"\"}]}]}"

    let mokeLastestResponse = "{\"success\":1,\"result\":[{\"event_key\":1183019,\"event_date\":\"2023-05-08\",\"event_time\":\"01:20\",\"event_home_team\":\"Millonarios\",\"home_team_key\":2273,\"event_away_team\":\"Santa Fe\",\"away_team_key\":2269,\"event_halftime_result\":\"1 - 0\",\"event_final_result\":\"1 - 0\",\"event_ft_result\":\"\",\"event_penalty_result\":\"\",\"event_status\":\"Half Time\",\"country_name\":\"Colombia\",\"league_name\":\"Primera A - Apertura\",\"league_key\":120,\"league_round\":\"Round 18\",\"league_season\":\"2023\",\"event_live\":\"1\",\"event_stadium\":\"Estadio Nemesio Camacho El Campin, Bogota\",\"event_referee\":\"Wilmar Roldan, Colombia\",\"home_team_logo\":\" \",\"away_team_logo\":\" \",\"event_country_key\":34,\"league_logo\":\" \",\"country_logo\":\" \",\"event_home_formation\":\"4-2-3-1\",\"event_away_formation\":\"4-2-3-1\",\"fk_stage_key\":813,\"stage_name\":\"Apertura\",\"league_group\":null}]}"

    let mokeSingleTeamResponse = "{\"success\":1,\"result\":[{\"team_key\":74,\"team_name\":\"Salzburg\",\"team_logo\":\" \",\"players\":[{\"player_key\":848260737,\"player_name\":\"P. Kohn\",\"player_number\":\"18\",\"player_country\":null,\"player_type\":\"Goalkeepers\",\"player_age\":\"25\",\"player_match_played\":\"27\",\"player_goals\":\"0\",\"player_yellow_cards\":\"2\",\"player_red_cards\":\"0\",\"player_image\":\" \"}]}]}"
    
}
extension MokeNetworkServices{
    func fetchLeaguesResult(sport: String, compilitionHandler: @escaping (SportsApp.Leagues?) -> Void) {
        let data = Data(mokeLeaguesResponse.utf8)
        do{
            let result = try JSONDecoder().decode(Leagues.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
    
    func fetchFixturesResult(sport: String, leagueId: Int, compilitionHandler: @escaping (SportsApp.UpcomingMatchesResult?) -> Void) {
        
        let data = Data(mokeFixtureResponse.utf8)
        
        do{
            let result = try JSONDecoder().decode(UpcomingMatchesResult.self, from: data)
            compilitionHandler(result)
        }catch let error{
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
    
    func fetchLastestScoreResult(sport: String, leagueId: Int, compilitionHandler: @escaping (SportsApp.LiveMatchesResult?) -> Void) {
            let data = Data(mokeLastestResponse.utf8)

            do{
                let result = try JSONDecoder().decode(LiveMatchesResult.self, from: data)
                compilitionHandler(result)
            }catch let error{
                print("Livescore\(error.localizedDescription)")
                compilitionHandler(nil)
            }
        }
    
    
    func fetchTeamsResult(sport: String, leagueId: Int, compilitionHandler: @escaping (SportsApp.AllTeamsResult?) -> Void) {
            let data = Data(mokeTeamsResponse.utf8)

            do{
                let result = try JSONDecoder().decode(AllTeamsResult.self, from: data)
                compilitionHandler(result)
            }catch let error{
                print("Teams \(error.localizedDescription)")
                compilitionHandler(nil)
            }
        }
        
        func fetchTeamDetailsResult(sport: String, teamId: Int, compilitionHandler: @escaping (SportsApp.TeamDetailsResult?) -> Void) {
            let data = Data(mokeSingleTeamResponse.utf8)

            do{
                let result = try JSONDecoder().decode(TeamDetailsResult.self, from: data)
                compilitionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                compilitionHandler(nil)
            }
        }
    
    
}
