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
