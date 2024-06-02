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
    static let shared = DatabaseManager(persistentContainer: (UIApplication.shared.delegate as! AppDelegate).persistentContainer)
    
    var persistentContainer: NSPersistentContainer
    private var favoriteLeagues = [FavoriteLeagues]()
    var onFavoritesChanged: (() -> Void)?
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.favoriteLeagues = fetchFavoriteLeaguesFromCoreData()
    }

    // Function to insert a league into Core Data
    func insertLeague(league: FavoriteLeagues) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavLeague", in: context)!
        let favLeague = NSManagedObject(entity: entity, insertInto: context)
        
        favLeague.setValue(league.leagueName, forKey: "leagueName")
        favLeague.setValue(Int32(league.leagueKey), forKey: "leagueKey")
        favLeague.setValue(league.leagueLogo, forKey: "leagueLogo")
        favLeague.setValue(league.sportName, forKey: "sportName")
        
        do {
            try context.save()
            favoriteLeagues.append(league)
            onFavoritesChanged?()
            print("League saved to Core Data and added to favorite leagues array.")
        } catch {
            print("Error saving league to Core Data: \(error.localizedDescription)")
        }
    }

    // Function to fetch all favorite leagues from Core Data
    private func fetchFavoriteLeaguesFromCoreData() -> [FavoriteLeagues] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeague")
        
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
    
    // Public method to get favorite leagues
    func getFavoriteLeagues() -> [FavoriteLeagues] {
        return favoriteLeagues
    }
    
    // Function to check if a league is already in Core Data
    func isLeagueFavorite(leagueKey: Int) -> Bool {
        return favoriteLeagues.contains { $0.leagueKey == leagueKey }
    }

    // Function to delete a league from Core Data
    func deleteFavLeague(leagueKey: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
        
        do {
            let fetchedLeagues = try context.fetch(fetchRequest)
            for object in fetchedLeagues {
                context.delete(object as! NSManagedObject)
            }
            try context.save()
            favoriteLeagues.removeAll { $0.leagueKey == leagueKey }
            onFavoritesChanged?()
            print("League deleted from Core Data and removed from favorite leagues array.")
        } catch let error {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
}
