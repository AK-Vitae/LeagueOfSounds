//
//  ChampionDetailedDataModel.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/13/21.
//

import Foundation

// MARK: - ChampionData
struct ChampionDetailedData: Codable {
    let type, format, version: String
    let data: [String: DetailedDatum]
}
//
// MARK: - Datum
struct DetailedDatum: Codable {
    let id, key, name, title: String
    let lore, blurb: String
    let info: Info
    let image: Image
    let tags: [Tag]
    let partype: String
    let stats: [String: Double]
    let spells: [Spell]
    let passive: Passive
}
//
// MARK: - Image
struct DetailedImage: Codable {
    let full, sprite, group: String
    let x, y, w, h: Int
}

// MARK: - Info
struct DetailedInfo: Codable {
    let attack, defense, magic, difficulty: Int
}

// MARK: - Spell
struct Spell: Codable {
    let id, name, spellDescription, tooltip: String

    enum CodingKeys: String, CodingKey {
          case id, name
          case spellDescription = "description"
          case tooltip
      }
}

// MARK: - Passive
struct Passive: Codable {
    let name, passiveDescription: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case name
        case passiveDescription = "description"
        case image
    }
}

enum DetailedTag: String, Codable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
}
