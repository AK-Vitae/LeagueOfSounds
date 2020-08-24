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

import Foundation

// MARK: - ClientVersion
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
    let image: Image
    let tags: [Tag]
    let partype: String
    let stats: [String: Double]
}

// MARK: - Image
struct Image: Codable {
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
    case the10161 = "10.16.1"
}

class FetchChampion: ObservableObject {
    @ObservedObject var clientVersion = FetchVersion()
    @Published var datas = [String()]
//        {
//        didSet {
//            print("\(self.datas.count) champions logged in ChampionData")
//        }
//    }
    
    init(client: FetchVersion) {
        loadData(version: client.version)
    }
    
    func loadData(version: String) {
        var urlString : String {
            return "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion.json"
        }
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let todoData = data {
                    let decodedData = try JSONDecoder().decode(ChampionData.self, from: todoData)
                    DispatchQueue.main.async {
                        let sortedData = decodedData.data.keys.sorted()
                        self.datas = sortedData
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
    @EnvironmentObject var version: FetchVersion
    
    var body: some View {
        ChampionDataInternalView(FetchChampion(client: version))
    }
}

struct ChampionDataInternalView: View {
    @EnvironmentObject var version : FetchVersion
    @ObservedObject var champion : FetchChampion
    init(_ champion: FetchChampion) {
        self.champion = champion
    }
    var body: some View {
        VStack(){
            Spacer()
            List(self.champion.datas, id: \.self) { champ in
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
