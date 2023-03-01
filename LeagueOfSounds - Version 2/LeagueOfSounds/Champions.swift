//
//  Champions.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/27/23.
//

import Foundation

struct Champions: Codable {
    let data: [String: Champion]
    
    func getChampionsAsSortedArray() -> [Champion] {
        let champions = Array(data.values).sorted { $0.name.lowercased() < $1.name.lowercased() }
        return champions
    }
}

struct Champion: Codable {
    let version, id, name, title: String
    let blurb: String
    let image: Image
    let tags: [Tag]
    
    func getChampionSquareAsset() { // Move this to an ImageView
        Task {
            let image = await NetworkManager.shared.downloadImage(currentApiVersion: version, for: id)
        }
    }
}

struct Image: Codable {
    let full: String
    let sprite: Sprite
}

enum Sprite: String, Codable {
    case champion0PNG = "champion0.png"
    case champion1PNG = "champion1.png"
    case champion2PNG = "champion2.png"
    case champion3PNG = "champion3.png"
    case champion4PNG = "champion4.png"
    case champion5PNG = "champion5.png"
}

enum Tag: String, Codable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
}
