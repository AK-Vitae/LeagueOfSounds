//
//  VersionManager.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 8/18/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI
import Foundation
class VersionManager : ObservableObject{
    @Published var version = String() {
        didSet {
            print("\(self.version) created in Version Manager")
        }
    }
    
    let clientVersionURL = "https://ddragon.leagueoflegends.com/realms/na.json"
    
    func fetchVersion(url: String) {
        let urlString = clientVersionURL
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.version = self.parseJSON(versionData: safeData)
                    //print(self.version)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(versionData: Data) -> String {
        let decoder = JSONDecoder()
        var output = String()
        do{
            let decodedData = try decoder.decode(ClientVersion.self, from: versionData)
            //print(decodedData.patch)
            output = decodedData.patch
        } catch {
            print(error)
        }
        return output
    }
    
}

struct ClientVersionView: View {
    @ObservedObject var manager = VersionManager()
    
    var body: some View {
        VStack{
            Text("Patch: \(manager.version)")
        }
    }
}

struct ClientVersionView_Previews: PreviewProvider {
    static var previews: some View {
        ClientVersionView()
    }
}

