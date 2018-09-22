//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Luis Herrera Lillo on 20-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!

    override func setUp() {
        starkSigil = Sigil(description: "Lobo Huargo", image: UIImage())
        lannisterSigil = Sigil(description: "Leon rampante", image: UIImage())
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        lannisterHouse = House(name: "Lanninster", sigil: lannisterSigil, words: "Oye mi rugido")
        
        robb = Person(name: "Robb", house: starkHouse, alias: "El joven Lobo")
        arya = Person(name: "Arya", house: starkHouse)
        
        tyrion = Person(name: "Tyrion", house: lannisterHouse, alias: "El enano")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
    }
    
    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    // Given - When - Then
    func testHouse_AddPersons_ReturnTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)
        
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        XCTAssertEqual(lannisterHouse.count, 0)
        
        lannisterHouse.add(person: tyrion)
        XCTAssertEqual(lannisterHouse.count, 1)
    }

}
