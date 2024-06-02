//
//  TeamDetailsServices.swift
//  SportsApp
//
//  Created by Ner Meen on 24/05/2024.
//

import Foundation
import Alamofire
func fetchTeam(sportName: String, teamId: String, completionHandler: @escaping (TeamDetailsResult?) -> Void) {
     let met = "Teams"
     let urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=\(met)&APIkey=\(Constants.apiKey)&teamId=\(teamId)"
     
     guard let url = URL(string: urlString) else {
         print("Invalid URL")
         completionHandler(nil)
         return
     }
     
     AF.request(url).responseData { response in
         switch response.result {
         case .success(let data):
             do {
                 if let jsonString = String(data: data, encoding: .utf8) {
                     print("Raw JSON response: \(jsonString)")
                 }
                 
                 let res = try JSONDecoder().decode(TeamDetailsResult.self, from: data)
                 completionHandler(res)
             } catch {
                 completionHandler(nil)
                 print("Error decoding data: \(error.localizedDescription)")
             }
         case .failure(let error):
             completionHandler(nil)
             print("Request error: \(error.localizedDescription)")
         }
     }
 }
