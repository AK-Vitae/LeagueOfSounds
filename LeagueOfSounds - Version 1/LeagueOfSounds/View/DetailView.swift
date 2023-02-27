//
//  DetailView.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/13/21.
//

import SwiftUI
import URLImage

struct DetailView: View {
    let champName: String
    let champChangedName: String
    let version: String
    
    var body: some View {
        URLImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champName)_0.jpg")!,
                 content: { image in
                    image
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                        .cornerRadius(6)
                 })
        Text(champChangedName)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(champName: "TestChampName", champChangedName: "Test ChampName", version: "TestVersion")
    }
}
