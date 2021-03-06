//
//  Character.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 20-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import Foundation

final class Person {
    
    // MARK: - Properties
    let name: String
    let house: House
    private let _alias: String?
    
    var alias: String {
//        if let alias = _alias {
//            // Si existe y esta guardado dentro de alias
//            return alias
//        } else {
//            return ""
//        }
        return _alias ?? "" // Devuelveme _alias, si hay algo, y si no, ""
    }
    
    // MARK: - Initialization
    
    // Se añade alias como parametro por defecto
    init(name: String, house: House, alias: String? = nil) {
        self.name = name
        self.house = house
        self._alias = alias
    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

extension Person {
    var proxyForEquality: String { // identificar inequivocamente a una person
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparison: String { // ordenar
        return fullName.uppercased()
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
    
}
