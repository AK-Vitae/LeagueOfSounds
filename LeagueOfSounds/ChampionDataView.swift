//
//  ChampionData.swift
//  LeagueOfSounds
//
//  Created by AK on 7/27/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI
import URLImage

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
        NavigationView {
            List(self.champion.datas, id: \.self) { champ in
                NavigationLink(destination: DetailView(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/\(self.version.version)/img/champion/\(champ).png")!)) {
                    HStack {
                        URLImage(URL(string: "https://ddragon.leagueoflegends.com/cdn/\(self.version.version)/img/champion/\(champ).png")!,
                                 delay: 0,
                                 processors: [ Resize(size: CGSize(width: 100.0, height: 100.0), scale: UIScreen.main.scale) ],
                                 content:  {
                                    $0.image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                        })
                            .frame(width: 100.0, height: 100.0)
                        Text("\(champ)")
                    }
                }
            }.navigationBarTitle(Text("Champions"))
        }
    }
}

struct ChampionDataView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionDataView()
    }
}
