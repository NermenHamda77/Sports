//
//  NetworkService.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 18/05/2024.
//

import Foundation


class NetworkService{
    
    func fetchLeaguesResult(sport: String, compilitionHandler: @escaping (Leagues?) -> Void) {
           let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=963d29cf248e5645a1d194a9fca0c26304519aa57383aeadfc6bf6a954af3d92")
           
           guard let newUrl = url else {
               return
           }
           let request = URLRequest(url: newUrl)
           let session = URLSession(configuration: .default)
           let task = session.dataTask(with: request){ data,response , error in
               do{
                   let result = try JSONDecoder().decode(Leagues.self, from: data ?? Data())
                   compilitionHandler(result)
               }catch let error{
                   print(error.localizedDescription)
                   compilitionHandler(nil)
               }
               
           }
           task.resume()
           
       }
}
