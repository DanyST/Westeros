//
//  Season.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 24-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    
    // MARK: - Properties
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes
    
    // MARK: - Initialization
    init(name: String, releaseDate: Date, episodes: Episodes = Episodes()) {
        self.name = name
        self.releaseDate = releaseDate
        self._episodes = episodes
    }
    
    convenience init(name: String, releaseDate: Date, episode: Episode) {
        self.init(name: name, releaseDate: releaseDate, episodes: Episodes(arrayLiteral: episode))
    }
}

extension Season {
    var numberOfEpisodes: Int {
       return  _episodes.count
    }
    
    func add(episode: Episode) {
        guard self == episode.season else { return }
        self._episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach { self.add(episode: $0) }
    }
}

// MARK: - Proxy
extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate) \(numberOfEpisodes)"
    }
    
    var proxyForComparison: Date {
        return releaseDate
    }
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        return "\(name). releaseDate at \(releaseDate). \(numberOfEpisodes) episodes"
    }
}

// MARK: - Equatable
extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}




