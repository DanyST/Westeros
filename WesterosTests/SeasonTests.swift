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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeasonExistence() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        
        let firstSeason = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "17/04/2011")!)
        
        XCTAssertNotNil(firstSeason)
    }

}
