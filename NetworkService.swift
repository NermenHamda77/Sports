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
                    print("JSON Response: \(jsonString)")
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
}

