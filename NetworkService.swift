//
//  NetworkService.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import Foundation

class NetworkService {
    
    private let API_KEY = "7d631bc915fda8279666dacfd6ad0494adff0b98bee2aec6126920bbe8754073"

    func fetchLeaguesResult(sport: String, completionHandler: @escaping (Leagues?) -> Void) {
        let urlString =  "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(API_KEY)"

        print("Fetching URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completionHandler(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completionHandler(nil)
                return
            }
            
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
        }
        task.resume()
    }
    
    func fetchFixturesResult(sport: String, leagueId: Int, completionHandler: @escaping (UpcomingMatchesResult?) -> Void) {
            let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leagueId)&APIkey=\(API_KEY)&from=2023-12-18&to=2024-04-18"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                    completionHandler(nil)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completionHandler(nil)
                    return
                }
                
                // Print raw JSON response for debugging
                if let jsonString = String(data: data, encoding: .utf8) {
                    //print("JSON Response: \(jsonString)")
                }
                
                //decode the JSON response
                do {
                    let result = try JSONDecoder().decode(UpcomingMatchesResult.self, from: data)
                    completionHandler(result)
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    completionHandler(nil)
                }
            }
            task.resume()
        }
    
    func fetchLiveScoreResult(sport: String, leagueId: Int, completion: @escaping (LiveMatchesResult?) -> Void) {
        
        let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leagueId)&APIkey=\(API_KEY)&from=2016-01-18&to=2018-01-18"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, _, error in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(LiveMatchesResult.self, from: data)
                    completion(result)
                } else {
                    completion(nil)
                }
            } catch let error {
                print("Livescore \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchTeamsResult(sport: String, leagueId: Int, compilitionHandler: @escaping (AllTeamsResult?) -> Void) {
        
    let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Teams&leagueId=\(leagueId)&APIkey=\(API_KEY)")
            
            guard let newUrl = url else {
                return
            }
            let request = URLRequest(url: newUrl)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request){ data,response , error in
                do{
                    let result = try JSONDecoder().decode(AllTeamsResult.self, from: data ?? Data())
                    compilitionHandler(result)
                }catch let error{
                    print("Teams \(error.localizedDescription)")
                    compilitionHandler(nil)
                }
                
            }
            task.resume()
        }
}

