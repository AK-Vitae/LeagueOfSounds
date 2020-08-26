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
    @ObservedObject var image : FetchImage
    public var body: some View {
        ZStack {
            Rectangle().fill(Color.gray)
            image.view?
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
            
            // (Optional) Animate image appearance
            .animation(.default)
            
            // (Optional) Cancel and restart requests during scrolling
            .onAppear(perform: image.fetch)
            .onDisappear(perform: image.cancel)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://cloud.githubusercontent.com/assets/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg")!
        return ImageView(image: FetchImage(url: url))
            .frame(width: 80, height: 80)
            .clipped()
    }
}
