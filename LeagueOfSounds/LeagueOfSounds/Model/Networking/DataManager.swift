//
//  DataManager.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/13/21.
//

import Foundation

class DataManager: ObservableObject {
    
    // MARK: - PROPERTIES
    @Published var champs = [String()]
    @Published var dataDict = [String: Datum]()
    @Published var versions = [String()]
    @Published var version = String()
    
    // MARK: - FUNCTIONS
    
    // MARK: - FETCHCHAMPIONDATA
    func fetchChampionData(version: String) {
        let urlString = "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion.json"
        if version == "" {
            print("Version did not load in")
        }
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        // MARK: - CREATE A URL
        if let url = URL(string: urlString) {
            
            // MARK: - CREATE A URLSESSION
            let session = URLSession(configuration: .default)
            
            // MARK: - GIVE THE SESSION A TASK
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let decodedData = try decoder.decode(ChampionData.self, from: safeData)
                            let sortedData = decodedData.data.keys.sorted()
                            let dataDict = decodedData.data
                            DispatchQueue.main.async {
                                self.dataDict = dataDict
                                self.champs = sortedData
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            // MARK: - START THE TASK
            task.resume()
        }
    }
    
    // MARK: - FETCHVERSION
    func fetchVersion(completion: @escaping (String?) -> Void) {
        let urlString = "https://ddragon.leagueoflegends.com/api/versions.json"
        // MARK: - CREATE A URL
        if let url = URL(string: urlString) {
            
            // MARK: - CREATE A URLSESSION
            let session = URLSession(configuration: .default)
            
            // MARK: - GIVE THE SESSION A TASK
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let decodedData = try decoder.decode(VersionData.self, from: safeData)
                            DispatchQueue.main.async {
                                self.versions = decodedData
                                self.version = decodedData[0]
                            }
                            completion(decodedData[0])
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            // MARK: - START THE TASK
            task.resume()
        }
    }
}

//                            let firstKey = Array(decodedData.data.keys)[0]
//
//                            let name = decodedData.data[firstKey]?.name
//                            let title = decodedData.data[firstKey]?.title
//                            let imageSource = decodedData.data[firstKey]?.image.full
//                            let lore = decodedData.data[firstKey]?.lore
//                            let tagOne = decodedData.data[firstKey]?.tags[0]
//                            let tagTwo = decodedData.data[firstKey]?.tags[1]
//                            let passive = decodedData.data[firstKey]?.passive.name
//                            let qAbility = decodedData.data[firstKey]?.spells[0].name
//                            let wAbility = decodedData.data[firstKey]?.spells[1].name
//                            let eAbility = decodedData.data[firstKey]?.spells[2].name
//                            let rAbility = decodedData.data[firstKey]?.spells[3].name
