//
//  ChampionImageSwiftUIView.swift
//  LeagueOfSounds
//
//  Created by Ramadugu, Akshith on 3/1/23.
//

import SwiftUI

struct ChampionImageSwiftUIView: View {

    var champion: Champion

    var body: some View {
        VStack {
            AsyncImage(url: champion.getChampionSquareAssetURL()) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                SwiftUI.Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
//            .clipShape(Circle())

            Text(champion.name)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

struct ChampionImageSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        // https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/Aatrox.png
        ChampionImageSwiftUIView(champion: Champion(version: "13.4.1",
                                        id: "Aatrox",
                                        name: "Aatrox",
                                        title: "",
                                        blurb: "", image: Image(full: "", sprite: Sprite.champion0PNG),
                                        tags: [Tag.fighter]))
    }
}
