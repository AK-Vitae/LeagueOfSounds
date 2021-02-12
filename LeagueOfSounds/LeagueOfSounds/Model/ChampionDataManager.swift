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
        let urlString = "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion.json"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // MARK: - CREATE A URL
        if let url = URL(string: urlString) {
            
            // MARK: - CREATE A URLSESSION
            let session = URLSession(configuration: .default)
            
            // MARK: - GIVE THE SESSION A TASK
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            
            // MARK: - START THE TASK
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
