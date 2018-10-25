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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeExistence() {
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "dd/mm/yyyy"
        
        let firstSeason = Season(name: "Primera temporada", releaseDate: dateFormmatter.date(from: "17/04/2011")!)

        let episode = Episode(name: "Primer episodio", releaseDate: dateFormmatter.date(from: "17/04/2011")!, season: firstSeason)
        
        XCTAssertNotNil(episode)
    }

}
