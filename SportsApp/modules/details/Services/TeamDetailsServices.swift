//
//  TeamDetailsServices.swift
//  SportsApp
//
//  Created by Ner Meen on 24/05/2024.
//

import Foundation

func fetchData(met: String, sportName: String, additionalParam: [String: String] ,completionHandler: @escaping (Data?, URLResponse?, Error?)->Void) {
    var urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=\(met)&APIkey=\(Constants.apiKey)"
    
    for (key,value) in additionalParam{
        urlString += "&\(key)=\(value)"
    }
    
    guard let url = URL(string: urlString) else{
        return
    }
    
    let req = URLRequest(url: url)
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: req, completionHandler: completionHandler)
    task.resume()
}

// MARK: fetching team details for football/basketball/cricket


func fetchTeam(sportName: String, teamId: String, completionHandler: @escaping (TeamDetailsResult?) -> Void) {
    
    fetchData(met: "Teams", sportName: sportName, additionalParam: ["teamId": teamId]) { data, _, error in
        do {
            guard let data = data else {
                print("No data returned from API")
                return
            }
            // Print raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            let res = try JSONDecoder().decode(TeamDetailsResult.self, from: data)
            completionHandler(res)
        } catch {
            completionHandler(nil)
            print("Error decoding data: \(error.localizedDescription)")
        }
    }
}

