//
//  leguesDetailsViewModelTest.swift
//  SportsAppTests
//
//  Created by Sarah Ahmed on 31/05/2024.
//

import XCTest
@testable import SportsApp

final class leguesDetailsViewModelTest: XCTestCase {
    
    var viewModel: LeaguesDetailsViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = LeaguesDetailsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test fetching upcoming events
        func testGetUpcomingEvents() {
            let expectation = self.expectation(description: "Fetch Upcoming Events")
            
            viewModel?.bindUpComingEventsToLeagueDetailsViewController = {
                XCTAssertNotNil(self.viewModel?.upComingEvents, "Upcoming events should not be nil")
                expectation.fulfill()
            }
            
            viewModel?.getUpComingEvents(sportType: "football", leagueId: 3)
            
            waitForExpectations(timeout: 5, handler: nil)
        }
        
        // Test fetching latest results
        func testGetLatestResults() {
            let expectation = self.expectation(description: "Fetch Latest Results")
            
            viewModel?.bindLatestResultsToLeagueDetailsViewController = {
                XCTAssertNotNil(self.viewModel?.latestResults, "Latest results should not be nil")
                expectation.fulfill()
            }
            
            viewModel?.getLatestResult(sportType: "football", leagueId: 3)
            
            waitForExpectations(timeout: 5, handler: nil)
        }
        
        // Test fetching teams
        func testGetTeams() {
            let expectation = self.expectation(description: "Fetch Teams")
            
            viewModel?.bindTeamsToLeagueDetailsViewController = {
                XCTAssertNotNil(self.viewModel?.teams, "Teams should not be nil")
                expectation.fulfill()
            }
            
            viewModel?.getTeams(sportType: "football", leagueId: 3)
            
            waitForExpectations(timeout: 5, handler: nil)
        }
    

}
