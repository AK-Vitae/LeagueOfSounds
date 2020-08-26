//
//  ImageLoader.swift
//  LeagueOfSounds
//
//  Created by AK on 7/25/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import Nuke
import FetchImage
import SwiftUI

public struct ImageView: View {
    @ObservedObject var image = FetchImage(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/champion/Aatrox.png")!)
    @ObservedObject var placeholder = FetchImage(url: URL(string: "https://github.com/AK-Vitae/LeagueOfSounds/blob/master/LeagueOfSounds/Assets.xcassets/placeholder.imageset/placeholder.png")!)
    public var body: some View {
        ZStack {
            Rectangle().fill(Color.gray)
            placeholder.view?
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
            .frame(width: 80, height: 80)
            .clipped()
            
            // (Optional) Animate image appearance
            .animation(.default)
            
            // (Optional) Cancel and restart requests during scrolling
            .onAppear(perform: placeholder.fetch)
            .onDisappear(perform: image.cancel)
            .onTapGesture {
//                self.placeholder.cancel()
//                self.image.fetch()
                playSound()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/champion/Aatrox.png")!
        return ImageView(image: FetchImage(url: url))
            .frame(width: 80, height: 80)
            .clipped()
    }
}
