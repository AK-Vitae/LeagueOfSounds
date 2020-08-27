//
//  URLImageList.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 8/26/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI
import URLImage

struct ListView : View {
    
    let urls: [URL]
    
    var body: some View {
        NavigationView {
            List(urls, id: \.self) { url in
                NavigationLink(destination: DetailView(url: url)) {
                    HStack {
                        URLImage(url,
                                 delay: 0.10,
                                 processors: [ Resize(size: CGSize(width: 100.0, height: 100.0), scale: UIScreen.main.scale) ],
                                 content:  {
                                    $0.image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                        })
                            .frame(width: 100.0, height: 100.0)
                        
                        Text("\(url)")
                    }
                }
            }
            .navigationBarTitle(Text("Champions"))
        }
    }
}

struct URLImageList_Previews: PreviewProvider {
    static var previews: some View {
        ListView(urls: [URL(string: "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/champion/Aatrox.png")!, URL(string: "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/champion/Aatrox.png")!])
    }
}
