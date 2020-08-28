//
//  UrlImageTest.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 8/26/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI
import URLImage

struct DetailView : View {
    
    let url: URL
    
    var body: some View {
        VStack{
            URLImage(url,
                     placeholder: {
                        ProgressView($0) { progress in
                            ZStack {
                                if progress > 0.0 {
                                    CircleProgressView(progress).stroke(lineWidth: 8.0)
                                }
                                else {
                                    CircleActivityView().stroke(lineWidth: 50.0)
                                }
                            }
                        }
                        .frame(width: 50.0, height: 50.0)
            },
                     content: {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(.all, 40.0)
                            .shadow(radius: 10.0)
                        //                    .onTapGesture {
                        //                        playSound()
                        //                }
            })
            AbilitiesView(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/10.16.1/img/spell/FlashFrost.png")!)
            Spacer()
        }
    }
}
