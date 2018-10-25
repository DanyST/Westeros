//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Luis Herrera Lillo on 25-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var firstSeason: Season!
    var secondSeason: Season!

    var firstEpisode: Episode!
    var firstEpisodeSecondSeason: Episode!

    override func setUp() {
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "dd/mm/yyyy"
        
        firstSeason = Season(name: "Temporada 1", releaseDate: dateFormmatter.date(from: "17/04/2011")!)
        
        firstEpisode = Episode(name: "Se acerca el invierno", releaseDate: dateFormmatter.date(from: "17/04/2011")!, season: firstSeason)
        
        secondSeason = Season(name: "Temporada 2", releaseDate: dateFormmatter.date(from: "01/04/2012")!)
        firstEpisodeSecondSeason = Episode(name: "En el Norte", releaseDate: dateFormmatter.date(from: "01/04/2012")!, season: secondSeason)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeExistence() {
        XCTAssertNotNil(firstEpisode)
    }
    
    func testCustomStringConvertible() {
        XCTAssertNotNil(firstEpisode.description)
    }
    
    func testEpisodeEquality() {
        // 1. Identidad
        XCTAssertEqual(firstEpisode, firstEpisode)
        
        // 2. Igualdad
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "dd/mm/yyyy"
        
        let season = Season(name: "Temporada 1", releaseDate: dateFormmatter.date(from: "17/04/2011")!)
        let episode = Episode(name: "Se acerca el invierno", releaseDate: dateFormmatter.date(from: "17/04/2011")!, season: season)
        
        XCTAssertEqual(firstEpisode, episode)
        
        // 3. Desigualdad
        XCTAssertNotEqual(firstEpisodeSecondSeason, firstEpisode)
    }
    
    func testEpisodeComparison() {
        XCTAssertGreaterThan(firstEpisodeSecondSeason, firstEpisode)
    }

}
