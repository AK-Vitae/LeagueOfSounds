//
//  ContentView.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/12/21.
//

import SwiftUI

struct ContentView: View {
    //KINGFISHER PACKAGE FOR IMAGES
    
    // MARK: - PROPERTIES
    let version: String
    @ObservedObject var versionManager = VersionDataManager()
    @ObservedObject var networkManager = ChampionDataManager()
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List(self.networkManager.champs, id: \.self) { champ in
                let newName = nameChange(champName: champ)
                NavigationLink(destination: DetailView(champName: champ, champChangedName: newName, version: version)) {
                    let title: String = networkManager.dataDict[champ]?.title ?? "No Title"
                    Text("\(newName), \(title). \(version)")
                } //: NAVIGATION LINK
            }
            .onTapGesture {
                self.versionManager.fetchVersion()
                self.networkManager.fetchChampionData(version: version)
            }
        } //: NAVIGATIONVIEW
    }
    
    // MARK: - FUNCTIONS
    func nameChange(champName: String) -> String {
        
        var newChampName: String = "No Name"
        switch champName {
        case "AurelionSol":
            newChampName = "Aurelion Sol"
        case "Chogath":
            newChampName = "Cho'Gath"
        case "DrMundo":
            newChampName = "Dr. Mundo"
        case "JarvanIV":
            newChampName = "Jarvan IV"
        case "Khazix":
            newChampName = "Kha'Zix"
        case "KogMaw":
            newChampName = "Kog'Maw"
        case "LeeSin":
            newChampName = "Lee Sin"
        case "MasterYi":
            newChampName = "Master Yi"
        case "MissFortune":
            newChampName = "Miss Fortune"
        case "MonkeyKing":
            newChampName = "Wukong"
        case "RekSai":
            newChampName = "Rek'Sai"
        case "TahmKench":
            newChampName = "Tahm Kench"
        case "TwistedFate":
            newChampName = "Twisted Fate"
        case "Velkoz":
            newChampName = "Vel'Koz"
        case "XinZhao":
            newChampName = "Xin Zhao"
        default:
            newChampName = champName
        }
        return newChampName
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(version: "11.3.1")
    }
}
