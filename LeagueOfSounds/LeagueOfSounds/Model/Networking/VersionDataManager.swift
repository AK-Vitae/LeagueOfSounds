//
//  VersionDataManager.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/13/21.
//

import Foundation

class VersionDataManager: ObservableObject {
    
    // MARK: - PROPERTIES
    @Published var versions = [String()]
    @Published var versionsFromData = [String()]
    
    // MARK: - FUNCTIONS
    func fetchVersion() {
        let urlString = "https://ddragon.leagueoflegends.com/api/versions.json"
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
                            let decodedData2 = try decoder.decode(VersionData.self, from: safeData)
                            DispatchQueue.main.async {
                                self.versionsFromData = decodedData2
                                print("version")
                                print(self.versionsFromData[0])
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
