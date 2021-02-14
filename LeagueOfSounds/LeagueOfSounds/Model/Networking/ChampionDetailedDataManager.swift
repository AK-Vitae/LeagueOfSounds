//
//  ChampionDetailedDataManager.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/13/21.
//

import Foundation

class ChampionDetailedDataManager: ObservableObject {
    
    // MARK: - PROPERTIES
    @Published var champs = [String()]
    @Published var dataDict = [String: Datum]()

    // MARK: - FUNCTIONS
    func fetchChampionDetailedData(version: String, champName: String) {
        let urlString = "http://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion/\(champName).json"
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
}
