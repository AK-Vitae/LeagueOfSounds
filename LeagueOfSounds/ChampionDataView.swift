//
//  ChampionData.swift
//  LeagueOfSounds
//
//  Created by AK on 7/27/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI

struct ChampionDataView: View {
    @EnvironmentObject var version: FetchVersion
    
    var body: some View {
        ChampionDataInternalView(champion: FetchChampion(client: version))
    }
}

struct ChampionDataInternalView: View {
    @EnvironmentObject var version : FetchVersion
    @ObservedObject var champion : FetchChampion
    
    init(champion: FetchChampion) {
        self.champion = champion
    }
    
    var body: some View {
        VStack(){
            Spacer()
            List(self.champion.datas, id: \.self) { champ in
                VStack(alignment: .leading) {
                    Text("\(champ)")
                }
            }
        }
    }
}

struct ChampionDataView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionDataView()
    }
}
