//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Luis Herrera Lillo on 29-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {
    
    var localHouses: [House]!
    var localSeasons: [Season]!
    
    override func setUp() {
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        
        XCTAssertGreaterThan(localHouses.count, 0)
        
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepositoryRetunsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnHouseByNameInsensitively() {
        let starkHouse = Repository.local.house(named: "StArK")
        XCTAssertEqual(starkHouse?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryHouseFiltering() {
        var filtered = Repository.local.houses { $0.count == 1 }
        XCTAssertEqual(filtered.count, 1)
        
        filtered = Repository.local.houses { $0.count == 100 }
        XCTAssertTrue(filtered.isEmpty)
    }
    
    func testLocalRepositorySeasonCreation() {
        XCTAssertNotNil(localSeasons)
        
        XCTAssertGreaterThan(localSeasons.count, 0)
        
        XCTAssertEqual(localSeasons.count, 7)
    }
    
    func testLocalRepositorySeasonFiltering() {
        var filtered = Repository.local.seasons { $0.numberOfEpisodes == 2 }
        XCTAssertEqual(filtered.count, 7)
        
        filtered = Repository.local.seasons { $0.numberOfEpisodes == 0 }
        XCTAssertTrue(filtered.isEmpty)
        
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "dd/MM/yyyy"
        
        filtered = Repository.local.seasons { $0.releaseDate < dateFormmatter.date(from: "01/01/2015")! }
        XCTAssertEqual(filtered.count, 4)
    }
    
    func testLocalRepositoryReturnSortedArrayOfEpisodes() {
        XCTAssertEqual(localSeasons, localSeasons.sorted())
    }

}
