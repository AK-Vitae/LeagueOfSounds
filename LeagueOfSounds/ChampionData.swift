//
//  ChampionData.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 7/27/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//
//   let championData = try? newJSONDecoder().decode(ChampionData.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - ChampionData
struct ChampionData: Codable {
    let type: TypeEnum
    let format: String
    let version: Version
    let data: [String: Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let version: Version
    let id, key, name, title: String
    let blurb: String
    let info: Info
    let image: Picture
    let tags: [Tag]
    let partype: String
    let stats: [String: Double]
}

// MARK: - Picture
struct Picture: Codable {
    let full: String
    let sprite: Sprite
    let group: TypeEnum
    let x, y, w, h: Int
}

enum TypeEnum: String, Codable {
    case champion = "champion"
}

enum Sprite: String, Codable {
    case champion0PNG = "champion0.png"
    case champion1PNG = "champion1.png"
    case champion2PNG = "champion2.png"
    case champion3PNG = "champion3.png"
    case champion4PNG = "champion4.png"
}

// MARK: - Info
struct Info: Codable {
    let attack, defense, magic, difficulty: Int
}

enum Tag: String, Codable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
}

enum Version: String, Codable {
    case the10151 = "10.16.1"
}

class FetchChampion: ObservableObject {
    @ObservedObject var clientVersion = FetchVersion()
    @Published var datas = [String()] {
        didSet {
            print("\(self.datas.count) champions logged in ChampionData")
        }
    }
    
    init() {
        print(clientVersion.version) // Prints nothing
        var ver : String = "10.15.1"
        var urlString : String {
                return "https://ddragon.leagueoflegends.com/cdn/\(ver)/data/en_US/champion.json"
        }
//        var urlString : String {
//                return "https://ddragon.leagueoflegends.com/cdn/\(clientVersion.version)/data/en_US/champion.json"
//        }
        print(urlString)
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) {(dataGappu, response, error) in
            do {
                if let jsonData = dataGappu {
                    let decodedData = try JSONDecoder().decode(ChampionData.self, from: jsonData)
                    DispatchQueue.main.async {
                        let sortedData = decodedData.data.keys.sorted()
                        self.datas = sortedData
                        //print(self.version)
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
            }
        }.resume()
    }
    
}

struct ChampionDataView: View {
    @ObservedObject var fetch = FetchChampion()
    var body: some View {
        VStack(){
            Spacer()
            List(self.fetch.datas, id: \.self) { champ in
                VStack(alignment: .leading) {
                    Text("\(champ)")
                }
            }
        }
    }
}

struct ChampionDataView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionDataView()
    }
}
