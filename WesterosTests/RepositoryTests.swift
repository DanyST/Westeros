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
    
    override func setUp() {
        localHouses = Repository.local.houses
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

}
