//
//  Repository.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 29-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias Filter = (House) -> Bool
    
    var houses: [House] { get }
    
    func house(named: String) -> House?
    
    func houses(filteredBy filter: Filter) -> [House]
}

final class LocalFactory: HouseFactory {
    
    var houses: [House] {
        
        // Houses creation here
        let starkSigil = Sigil(description: "Lobo Huargo", image: UIImage(named: "codeIsComing.png")!)
        let lannisterSigil = Sigil(description: "León Rampante", image: UIImage(named: "lannister.jpg")!)
        let targaryenSigil = Sigil(description: "Un dragón tricefalo", image: UIImage(named: "targaryenSmall.jpg")!)
        
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkUrl)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterUrl)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y sangre", url: targaryenUrl)
        
        // Characters creation
        let robb = Person(name: "Robb", house: starkHouse, alias: "El joven lobo")
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", house: lannisterHouse, alias: "El enano")
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", house: lannisterHouse, alias: "El matarreyes")
        let dani = Person(name: "Daenerys", house: targaryenHouse, alias: "Madre de dragones")
        
        // Add characters to houses
        starkHouse.add(persons: robb, arya)
        lannisterHouse.add(persons: tyrion, cersei, jaime)
        targaryenHouse.add(person: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
//        return houses.filter { $0.name.uppercased() == name.uppercased() }.first
        return houses.first { $0.name.uppercased() == name.uppercased() }
    }
    
    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
}
