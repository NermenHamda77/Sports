//
//  NetworkService.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import Foundation
import Alamofire

class NetworkService {

    static let API_KEY = "7d631bc915fda8279666dacfd6ad0494adff0b98bee2aec6126920bbe8754073"

        static func fetchLeaguesResult(sport: String, completionHandler: @escaping (Leagues?) -> Void) {
            let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(API_KEY)"

            print("Fetching URL: \(urlString)")
            
            AF.request(urlString).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            //print("JSON Response: \(jsonString)")
                        }
                        let result = try JSONDecoder().decode(Leagues.self, from: data)
                        completionHandler(result)
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        completionHandler(nil)
                    }
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                    completionHandler(nil)
                }
            }
        }
        
        static func fetchFixturesResult(sport: String, leagueId: Int, completionHandler: @escaping (UpcomingMatchesResult?) -> Void) {
            let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leagueId)&APIkey=\(API_KEY)&from=2023-12-18&to=2024-04-18"
            
            AF.request(urlString).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            //print("JSON Response: \(jsonString)")
                        }
                        let result = try JSONDecoder().decode(UpcomingMatchesResult.self, from: data)
                        completionHandler(result)
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        completionHandler(nil)
                    }
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                    completionHandler(nil)
                }
            }
        }
        
        static func fetchLiveScoreResult(sport: String, leagueId: Int, completion: @escaping (LiveMatchesResult?) -> Void) {
            let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leagueId)&APIkey=\(API_KEY)&from=2016-01-18&to=2018-01-18"
            
            AF.request(urlString).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(LiveMatchesResult.self, from: data)
                        completion(result)
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        
        static func fetchTeamsResult(sport: String, leagueId: Int, compilitionHandler: @escaping (AllTeamsResult?) -> Void) {
            let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Teams&leagueId=\(leagueId)&APIkey=\(API_KEY)"
            
            AF.request(urlString).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(AllTeamsResult.self, from: data)
                        compilitionHandler(result)
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        compilitionHandler(nil)
                    }
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                    compilitionHandler(nil)
                }
            }
        }
    
}

