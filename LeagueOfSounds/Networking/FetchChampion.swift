//
//  FetchChampion.swift
//  LeagueOfSounds
//
//  Created by AK on 8/24/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import Foundation
import SwiftUI

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
                        print("Worked")
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
