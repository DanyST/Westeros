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

protocol SeasonFactory {
    typealias SeasonFilter = (Season) -> Bool
    
    var seasons: [Season] { get }
    
    func seasons(filteredBy: SeasonFilter) -> [Season]
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

extension LocalFactory: SeasonFactory {
  
    var seasons: [Season] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        // Seasons creation
        let firstSeason = Season(name: "Season 1", releaseDate: dateFormatter.date(from: "17/04/2011")!)
        let secondSeason = Season(name: "Season 2", releaseDate: dateFormatter.date(from: "01/04/2012")!)
        let thirthSeason = Season(name: "Season 3", releaseDate: dateFormatter.date(from: "31/03/2013")!)
        let fourthSeason = Season(name: "Season 4", releaseDate: dateFormatter.date(from: "06/04/2014")!)
        let fifthSeason = Season(name: "Season 5", releaseDate: dateFormatter.date(from: "12/04/2015")!)
        let sixthSeason = Season(name: "Season 6", releaseDate: dateFormatter.date(from: "24/04/2016")!)
        let seventhSeason = Season(name: "Season 7", releaseDate: dateFormatter.date(from: "27/08/2017")!)
        
        // Episodes creation
        let episode01x01 = Episode(name: "Winter Is Coming", releaseDate: dateFormatter.date(from: "17/04/2011")!, season: firstSeason)
        let episode02x01 = Episode(name: "The Kingsroad ", releaseDate: dateFormatter.date(from: "24/04/2011")!, season: firstSeason)
        
        let episode01x02 = Episode(name: "The North Remembers", releaseDate: dateFormatter.date(from: "01/04/2012")!, season: secondSeason)
        let episode02x02 = Episode(name: "The Night Lands", releaseDate: dateFormatter.date(from: "08/04/2012")!, season: secondSeason)
        
        let episode01x03 = Episode(name: "Valar Dohaeris", releaseDate: dateFormatter.date(from: "31/03/2013")!, season: thirthSeason)
        let episode02x03 = Episode(name: "Dark Wings, Dark Words", releaseDate: dateFormatter.date(from: "07/04/2013")!, season: thirthSeason)
        
        let episode01x04 = Episode(name: "Two Swords", releaseDate: dateFormatter.date(from: "06/04/2014")!, season: fourthSeason)
        let episode02x04 = Episode(name: "The Lion and the Rose", releaseDate: dateFormatter.date(from: "13/04/2014")!, season: fourthSeason)
        
        let episode01x05 = Episode(name: "The Wars to Come", releaseDate: dateFormatter.date(from: "12/04/2015")!, season: fifthSeason)
        let episode02x05 = Episode(name: "The House of Black and White", releaseDate: dateFormatter.date(from: "19/04/2015")!, season: fifthSeason)
        
        let episode01x06 = Episode(name: "The Red Woman", releaseDate: dateFormatter.date(from: "24/06/2016")!, season: sixthSeason)
        let episode02x06 = Episode(name: "Home", releaseDate: dateFormatter.date(from: "01/05/2016")!, season: sixthSeason)
        
        let episode01x07 = Episode(name: "Dragonstone", releaseDate: dateFormatter.date(from: "16/07/2017")!, season: seventhSeason)
        let episode02x07 = Episode(name: "Stormborn", releaseDate: dateFormatter.date(from: "23/07/2017")!, season: seventhSeason)
        
        // Add episodes to seasons
        firstSeason.add(episodes: episode01x01, episode02x01)
        secondSeason.add(episodes: episode01x02, episode02x02)
        thirthSeason.add(episodes: episode01x03, episode02x03)
        fourthSeason.add(episodes: episode01x04, episode02x04)
        fifthSeason.add(episodes: episode01x05, episode02x05)
        sixthSeason.add(episodes: episode01x06, episode02x06)
        seventhSeason.add(episodes: episode01x07, episode02x07)
        
        return [firstSeason, secondSeason, thirthSeason, fourthSeason, fifthSeason, sixthSeason, seventhSeason].sorted()
        
    }
    
    func seasons(filteredBy: SeasonFilter) -> [Season] {
        return seasons.filter(filteredBy)
    }
    
}
