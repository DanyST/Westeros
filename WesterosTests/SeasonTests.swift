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

    override func setUp() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        
        firstSeason = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "17/04/2011")!)
        secondSeason = Season(name: "Temporada 2", releaseDate: dateFormatter.date(from: "01/04/2012")!)
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
    
}
