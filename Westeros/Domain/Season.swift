//
//  Season.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 24-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import Foundation

typealias Episodes = Array<Episode>

final class Season {
    
    // MARK: - Properties
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes
    
    // MARK: - Initialization
    init(name: String, releaseDate: Date, episodes: Episodes = Episodes()) {
        // Nos encargamos de nuestras propias variables
        self.name = name
        self.releaseDate = releaseDate
        self._episodes = episodes
    }
    
    convenience init(name: String, releaseDate: Date, episode: Episode) {
        self.init(name: name, releaseDate: releaseDate, episodes: Episodes(arrayLiteral: episode))
    }
}
