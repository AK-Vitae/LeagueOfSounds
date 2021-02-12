//
//  ChampionDataManager.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/12/21.
//

import Foundation

struct ChampionDataManager {
    
    // MARK: - FUNCTIONS
    func fetchChampionData(version: String) {
        //func fetchChampionData(version: String, champion: String)
//        let urlString = "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion/\(champion).json"
        let urlString = "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion.json"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // MARK: - CREATE A URL
        if let url = URL(string: urlString) {
            
            // MARK: - CREATE A URLSESSION
            let session = URLSession(configuration: .default)
            
            // MARK: - GIVE THE SESSION A TASK
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    parseJSON(championData: safeData)
                }
            }
            
            // MARK: - START THE TASK
            task.resume()
        }
    }
    
    func parseJSON(championData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ChampionData.self, from: championData)
            for k in decodedData.data.keys.sorted() {
                print(k)
            }
        } catch {
            print(error)
        }
    }
}
