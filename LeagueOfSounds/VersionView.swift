//
//  VersionView.swift
//  LeagueOfSounds
//
//  Created by AK on 7/25/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI


class FetchVersion: ObservableObject {
    @Published var version = String() {
        didSet {
            print("\(self.version) created in VersionView")
        }
    }
    
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


struct VersionView: View {
    @ObservedObject var fetch = FetchVersion()
    
    var body: some View {
        VStack{
            Text("Patch: \(fetch.version)")
        }.onAppear()
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        VersionView()
    }
}
