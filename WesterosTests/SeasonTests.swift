//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Luis Herrera Lillo on 24-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    
    var firstSeason: Season!
    var secondSeason: Season!
    
    var episode01x01: Episode!
    var episode02x01: Episode!
    var episode01x02: Episode!
    var episode02x02: Episode!
    

    override func setUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        
        firstSeason = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "17/04/2011")!)
        secondSeason = Season(name: "Temporada 2", releaseDate: dateFormatter.date(from: "01/04/2012")!)
        
        episode01x01 = Episode(name: "Winter Is Coming", releaseDate: dateFormatter.date(from: "17/04/2011")!, season: firstSeason)
        episode02x01 = Episode(name: "The Kingsroad ", releaseDate: dateFormatter.date(from: "24/04/2011")!, season: firstSeason)
        
        episode01x02 = Episode(name: "The North Remembers", releaseDate: dateFormatter.date(from: "01/04/2012")!, season: secondSeason)
        episode02x02 = Episode(name: "The Night Lands", releaseDate: dateFormatter.date(from: "08/04/2012")!, season: secondSeason)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeasonExistence() {
        XCTAssertNotNil(firstSeason)
    }
    
    func testSeasonCustomStringConvertible() {
        XCTAssertNotNil(firstSeason.description)
    }
    
    func testSeasonEquality() {
        // 1. Identidad
        XCTAssertEqual(firstSeason, firstSeason)
        
        // 2. Igualdad
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        
        let season = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "17/04/2011")!)
        
        XCTAssertEqual(firstSeason, season)
        
        // 3. Desigualdad
        XCTAssertNotEqual(firstSeason, secondSeason)
    }
    
    func testSeasonComparison() {
        XCTAssertGreaterThan(secondSeason, firstSeason)
    }
    
    func testSeason_AddEpisodes_ReturnTheCorrectCountOfEpisodes() {
        XCTAssertEqual(firstSeason.numberOfEpisodes, 0)
        
        firstSeason.add(episodes: episode01x01, episode02x01)
        XCTAssertEqual(firstSeason.numberOfEpisodes, 2)
        
        firstSeason.add(episodes: episode01x02, episode01x02)
        XCTAssertEqual(firstSeason.numberOfEpisodes, 2)
        
        firstSeason.add(episodes: episode01x01, episode02x01)
        XCTAssertEqual(firstSeason.numberOfEpisodes, 2)
        
        XCTAssertEqual(secondSeason.numberOfEpisodes, 0)
        
        secondSeason.add(episodes: episode01x02, episode02x02)
        XCTAssertEqual(secondSeason.numberOfEpisodes, 2)
        
        secondSeason.add(episodes: episode01x01, episode02x01)
        XCTAssertEqual(secondSeason.numberOfEpisodes, 2)
    }
    
}
