//
//  ContentView.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/12/21.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    var championDataManager = ChampionDataManager()
    let versionTest: String = "11.3.1"
    
    // MARK: - BODY
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onTapGesture {
                championDataManager.fetchChampionData(version: versionTest)
            }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
