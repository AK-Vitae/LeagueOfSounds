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
    func fetchVersion() {
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
    
    func getChampAndVersion() { // Just testing to see if opertion queues would help
        let operationQueue = OperationQueue()
        
        let blockOperationOne = BlockOperation {
            print("version starting")
            self.fetchVersion()
            print("version ending")
        }
        
        let blockOperationTwo = BlockOperation {
            print("champion starting")
            self.fetchChampionData(version: self.version)
            print("champion ending")
        }
        
        blockOperationTwo.addDependency(blockOperationOne)
        operationQueue.addOperation(blockOperationOne)
        operationQueue.addOperation(blockOperationTwo)
        operationQueue.waitUntilAllOperationsAreFinished()
        print("finished")
    }
}
