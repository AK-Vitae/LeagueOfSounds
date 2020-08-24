//
//  FetchVersion.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 8/24/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import Foundation

class FetchVersion: ObservableObject {
    @Published var version = String()
//        {
//        didSet {
//            print("\(self.version) created in VersionView")
//        }
//    }
    
    init() {
        loadVersion()
    }
    
    func loadVersion() {
        guard let url = URL(string: "https://ddragon.leagueoflegends.com/realms/na.json") else {
            fatalError("Invalid URL")
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let todoData = data {
                    let decodedData = try JSONDecoder().decode(ClientVersion.self, from: todoData)
                    DispatchQueue.main.async {
                        self.version = decodedData.patch
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
