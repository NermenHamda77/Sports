//
//  NetworkServiceTest.swift
//  SportsAppTests
//
//  Created by Ner Meen on 27/05/2024.
//

import XCTest
@testable import SportsApp

final class NetworkServiceTest: XCTestCase {
    
    // fetchLeaguesResult

    func testfetchLeaguesResult () {
        // Given:
        let expectation = expectation(description: "Waiting for the API")
        NetworkService.fetchLeaguesResult(sport: "football"){ res in
            // When:
            guard let _ = res else {
                // Then:
                XCTFail("Result returned was nil.")
                expectation.fulfill()
                return
            }
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 5)

    }


    //fetchFixturesResult(upcoming)

    func testfetchFixturesResultFootballNotNil() {
        // Given:
        let expectation = expectation(description: "Waiting for the API")
        NetworkService.fetchFixturesResult(sport: "football", leagueId: 3) { res in
            // When:
            guard let res = res else {
                // Then:
                XCTFail("Result returned was nil.")
                expectation.fulfill()
                return
            }
            let upcomingMatchesFootball = res.result
            // Then:
            XCTAssertNotNil(upcomingMatchesFootball)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 5)

    }


    func testfetchFixturesResultTennisNil () {
        // Given:
        let expectation = expectation(description: "Waiting for the API")
        NetworkService.fetchFixturesResult(sport: "tennis", leagueId: 3) { res in
            // When: The response is received
            guard let res = res else {
                // Then:
                XCTFail("Result returned was nil.")
                expectation.fulfill()
                return
            }
            // Then:
            XCTAssertNil(res.result)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 5)

    }


    //lastest
    func testFetchLestestResult() {
          let expectation = expectation(description: "Waiting for Api")
          NetworkService.fetchLiveScoreResult(sport: "football" , leagueId: 257){ result in
              guard let liveScore = result else{
                  XCTFail()
                  expectation.fulfill()
                  return
              }
              XCTAssertNotEqual(liveScore.result?.count, 0)
              expectation.fulfill()
          }
          waitForExpectations(timeout: 5)
      }

    //teams
    func testFetchTeamsResult() {
            let expectation = expectation(description: "Waiting for Api")
        NetworkService.fetchTeamsResult(sport: "football",leagueId: 4){ result in
                guard let teams = result else{
                    XCTFail()
                    expectation.fulfill()
                    return
                }
                XCTAssertNotEqual(teams.result?.count, 0)
                expectation.fulfill()
            }
            waitForExpectations(timeout: 5)
        }

}
