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
    case the10151 = "10.15.1"
}

class FetchChampion: ObservableObject {
    @Published var datas = [String()]
    
    init() {
        let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.15.1/data/en_US/champion.json")!
        URLSession.shared.dataTask(with: url) {(dataGappu, response, error) in
            do {
                if let jsonData = dataGappu {
                    let decodedData = try JSONDecoder().decode(ChampionData.self, from: jsonData)
                    DispatchQueue.main.async {
                        let sortedData = decodedData.data.keys.sorted()
                        self.datas = sortedData // Sorted data is of type Array<String>
//                        print(sortedData[0])
//                        print(type(of: sortedData))
//                        print(sortedData.count)
//                        for champ in sortedData {
//                            print("\(champ)")
//                        }
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
            VStack(alignment: .leading, spacing: 10){
                Text("Champion at first index: \(self.fetch.datas[0])")
//                Text("\(self.fetch.datas[1])") // Index out of range
                Text("Number of champions: \(self.fetch.datas.count)") // Shows 149
                    .onAppear(perform: {print(self.fetch.datas.indices)
                    print(self.fetch.datas.count) // Prints out 1
                })
            }
    }
}

struct ChampionDataView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionDataView()
    }
}
