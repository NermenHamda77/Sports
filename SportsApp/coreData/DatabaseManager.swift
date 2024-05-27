//
//  DatabaseManager.swift
//  SportsApp
//
//  Created by Ner Meen on 26/05/2024.
//
import Foundation
import UIKit
import CoreData

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private var favoriteLeagues = [FavoriteLeagues]()
    
    var onFavoritesChanged: (() -> Void)?
    
    private init() {
        favoriteLeagues = fetchFavoriteLeaguesFromCoreData()
    }
    
    // add league in Core Data
    func insertLeague(league: FavoriteLeagues) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteLeague", in: context)!
        let favLeague = NSManagedObject(entity: entity, insertInto: context)
        
        favLeague.setValue(league.leagueName, forKey: "leagueName")
        favLeague.setValue(Int32(league.leagueKey), forKey: "leagueKey")
        favLeague.setValue(league.leagueLogo, forKey: "leagueLogo")
        favLeague.setValue(league.sportName, forKey: "sportName")
        
        do {
            try context.save()
            favoriteLeagues.append(league)
            onFavoritesChanged?()
            print("League added to Core Data")
        } catch {
            print("Error while adding league to Core Data: \(error.localizedDescription)")
        }
    }

    // fetch all favorite leagues from Core Data
    private func fetchFavoriteLeaguesFromCoreData() -> [FavoriteLeagues] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeague")
        
        do {
            let favLeagues = try context.fetch(fetchRequest)
            return favLeagues.compactMap { league in
                guard let leagueName = league.value(forKey: "leagueName") as? String,
                      let leagueKey = league.value(forKey: "leagueKey") as? Int,
                      let leagueLogo = league.value(forKey: "leagueLogo") as? String,
                      let sportName = league.value(forKey: "sportName") as? String else { return nil }
                return FavoriteLeagues(leagueName: leagueName, leagueKey: leagueKey, leagueLogo: leagueLogo, sportName: sportName)
            }
        } catch let error {
            print("Error fetching data: \(error.localizedDescription)")
            return []
        }
    }
    
    
    func getFavoriteLeagues() -> [FavoriteLeagues] {
        return favoriteLeagues
    }
    
   
    func isLeagueFavorite(leagueKey: Int) -> Bool {
        return favoriteLeagues.contains { $0.leagueKey == leagueKey }
    }

    // delete league from Core Data
    func deleteFavLeague(leagueKey: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
        
        do {
            let fetchedLeagues = try context.fetch(fetchRequest)
            for object in fetchedLeagues {
                context.delete(object as! NSManagedObject)
            }
            try context.save()
            favoriteLeagues.removeAll { $0.leagueKey == leagueKey }
            onFavoritesChanged?()
            
        } catch let error {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
}
