//
//  AbilitiesView.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 8/28/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI
import URLImage

struct AbilitiesView : View {
    
    let url: URL
    
    var body: some View {
        HStack{
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
                            .frame(width: 75, height: 75)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            //.padding()
                            .shadow(radius: 10.0)
                        //                    .onTapGesture {
                        //                        playSound()
                        //                }
            })
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
                            .frame(width: 75, height: 75)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            //.padding()
                            .shadow(radius: 10.0)
                        //                    .onTapGesture {
                        //                        playSound()
                        //                }
            })
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
                            .frame(width: 75, height: 75)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            //.padding()
                            .shadow(radius: 10.0)
                        //                    .onTapGesture {
                        //                        playSound()
                        //                }
            })
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
                            .frame(width: 75, height: 75)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            //.padding()
                            .shadow(radius: 10.0)
                        //                    .onTapGesture {
                        //                        playSound()
                        //                }
            })
        }
    }
}
