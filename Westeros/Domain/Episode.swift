//
//  Episode.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 25-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import Foundation

final class Episode {
    
    // MARK: - Properties
    let name: String
    let releaseDate: Date
    weak var season: Season?
    
    // MARK: - Initialization
    init(name: String, releaseDate: Date, season: Season) {
        self.name = name
        self.releaseDate = releaseDate
        self.season = season
    }
}

// MARK: - Proxy
extension Episode {
    var proxyForEquality: String {
        return "\(name) \(releaseDate) \(season?.name ?? "" )"
    }
    
    var proxyForComparison: Date {
        return releaseDate
    }
}

// MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible {
    var description: String {
        return "\(name). Episode released at \(releaseDate) from \(season?.name ?? "")"
    }
}

// MARK: - Equatable
extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
}

