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
    //    let version: String
    @ObservedObject var dataManager = DataManager()
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(self.dataManager.champs, id: \.self) { champ in
                    let champChangedName = nameChange(champName: champ)
                    NavigationLink(destination: DetailView(champName: champ, champChangedName: champChangedName, version: dataManager.versions[0])) {
                        let title: String = dataManager.dataDict[champ]?.title ?? "No Title"
                        HStack {
                            Text("\(champChangedName), \(title)")
                        } //: HSTACK
                        .padding(.vertical, 10)
                    } //: NAVIGATIONLINK
                } //: FOREACH
            } //: LIST
            .listStyle(InsetGroupedListStyle())
            .onAppear {
                dataManager.fetchVersion { v in
                    dataManager.fetchChampionData(version: v ?? "11.3.1")
                }
            }
            .navigationBarHidden(true)
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
        ContentView()
    }
}
