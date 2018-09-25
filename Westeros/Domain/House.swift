//
//  House.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 20-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>

final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    private var _members: Members
    
    init(name: String, sigil: Sigil, words: Words) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self._members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    func add(person: Person) {
        guard self == person.house else { return }
        _members.insert(person)
    }
}

extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        // Orden alfabético
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
