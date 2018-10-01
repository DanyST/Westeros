//
//  CharacterTest.swift
//  WesterosTests
//
//  Created by Luis Herrera Lillo on 20-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import XCTest
// añadimos acceso a los archivos de mi proyecto
@testable import Westeros // acceder a todo el codigo, incluso si es privado

class PersonTests: XCTestCase {
    
    var starkHouse: House!
    var starkSigil: Sigil!
    var ned: Person!
    var arya: Person!
    
    override func setUp() {
        starkSigil = Sigil(description: "Lobo huargo", image: UIImage())
        
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!

        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkUrl)
        ned = Person(name: "Eddard", house: starkHouse, alias: "Ned")
        arya = Person(name: "Arya", house: starkHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterExistence() {
        XCTAssertNotNil(ned)
        XCTAssertNotNil(arya)
    }
    
    func testPersonFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
        XCTAssertEqual(arya.fullName, "Arya Stark")
    }
    
    func testPersonEquality() {
        // 1. Identidad
        XCTAssertEqual(ned, ned)
        
        // 2. Igualdad
        let eddard = Person(name: "Eddard", house: starkHouse, alias: "Ned")
        XCTAssertEqual(eddard, ned)
        
        // 3. Desigualdad
        XCTAssertNotEqual(ned, arya)
    }
    
    func testPersonHashable() {
        XCTAssertNotNil(ned.hashValue)
    }
    
    func testPersonComparison() {
        XCTAssertGreaterThan(ned, arya)
    }
    
    func testHouseSortedMembersReturnsASortedArray() {
        
    }
}
