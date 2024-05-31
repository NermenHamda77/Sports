//
//  DatabaseManagerTest.swift
//  SportsAppTests
//
//  Created by Ner Meen on 28/05/2024.
//


import XCTest
import CoreData
@testable import SportsApp

final class DatabaseManagerTest: XCTestCase {
    
    var databaseManager: DatabaseManager!
    var mockPersistentContainer: NSPersistentContainer!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // in-memory Core Data
        mockPersistentContainer = NSPersistentContainer(name: "SportsApp")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        mockPersistentContainer.persistentStoreDescriptions = [description]
        
        mockPersistentContainer.loadPersistentStores { (description, error) in
            XCTAssertNil(error)
        }
        
        // Initialize DatabaseManager with the in-memory container
        databaseManager = DatabaseManager(persistentContainer: mockPersistentContainer)
    }

    override func tearDownWithError() throws {
        databaseManager = nil
        mockPersistentContainer = nil
        try super.tearDownWithError()
    }
    
    func testInsertLeague() {
        let league = FavoriteLeagues(leagueName: "Premier League", leagueKey: 1, leagueLogo: "logo.png", sportName: "Football")
        
        databaseManager.insertLeague(league: league)
        
        let fetchedLeagues = databaseManager.getFavoriteLeagues()
        
        XCTAssertEqual(fetchedLeagues.count, 1)
        XCTAssertEqual(fetchedLeagues.first?.leagueName, "Premier League")
    }

    func testDeleteLeague() {
        let league = FavoriteLeagues(leagueName: "Premier League", leagueKey: 1, leagueLogo: "logo.png", sportName: "Football")
        
        databaseManager.insertLeague(league: league)
        databaseManager.deleteFavLeague(leagueKey: league.leagueKey)
        
        let fetchedLeagues = databaseManager.getFavoriteLeagues()
        
        XCTAssertTrue(fetchedLeagues.isEmpty)
    }
    
    func testFetchFavoriteLeaguesFromCoreData() {
        let league1 = FavoriteLeagues(leagueName: "Premier League", leagueKey: 1, leagueLogo: "logo1.png", sportName: "Football")
        let league2 = FavoriteLeagues(leagueName: "La Liga", leagueKey: 2, leagueLogo: "logo2.png", sportName: "Football")
        
        databaseManager.insertLeague(league: league1)
        databaseManager.insertLeague(league: league2)
        
        let fetchedLeagues = databaseManager.getFavoriteLeagues()
        
        XCTAssertEqual(fetchedLeagues.count, 2)
        XCTAssertTrue(fetchedLeagues.contains(where: { $0.leagueKey == 1 }))
        XCTAssertTrue(fetchedLeagues.contains(where: { $0.leagueKey == 2 }))
    }
    
    func testIsLeagueFavorite() {
        let league = FavoriteLeagues(leagueName: "Premier League", leagueKey: 1, leagueLogo: "logo.png", sportName: "Football")
        
        databaseManager.insertLeague(league: league)
        
        XCTAssertTrue(databaseManager.isLeagueFavorite(leagueKey: 1))
        XCTAssertFalse(databaseManager.isLeagueFavorite(leagueKey: 2))
    }
}
