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
    var houses: [House] { get }
}

final class LocalFactory: HouseFactory {
    var houses: [House] {
        
        // Houses creation here
        let starkSigil = Sigil(description: "Lobo Huargo", image: UIImage(named: "codeIsComing.png")!)
        let lannisterSigil = Sigil(description: "León Rampante", image: UIImage(named: "lannister.jpg")!)
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        // Characters creation
        let robb = Person(name: "Robb", house: starkHouse, alias: "El joven lobo")
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", house: lannisterHouse, alias: "El enano")
        
        // Add characters to houses
        starkHouse.add(person: robb)
        starkHouse.add(person: arya)
        lannisterHouse.add(person: tyrion)
        
        return [starkHouse, lannisterHouse]
    }
}
