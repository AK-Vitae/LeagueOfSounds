//
//  ChampionVersionView.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/13/21.
//

import SwiftUI

struct ChampionVersionView: View {
    @StateObject var dataManager = DataManager()
    
    var body: some View {
        List(self.dataManager.versions, id: \.self) { version in
            HStack {
                Text("\(version)")
                Text(dataManager.champs[0])
            }
        }
        .onAppear {
            dataManager.fetchVersion() // Need to run this first and to assign dataManager.version
            dataManager.fetchChampionData(version: dataManager.version) // Use dataManger.version to get to the champions url
        }
    }
        

    }
    
    struct ChampionVersionView_Previews: PreviewProvider {
        static var previews: some View {
            ChampionVersionView()
        }
    }
