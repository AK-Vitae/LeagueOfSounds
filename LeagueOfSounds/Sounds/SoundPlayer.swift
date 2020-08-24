//
//  SoundPlayer.swift
//  LeagueOfSounds
//
//  Created by AK on 7/27/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import AVFoundation

var player: AVAudioPlayer?

func playSound() {
    let path = Bundle.main.path(forResource: "aatroxTest.wav", ofType:nil)!
    let url = URL(fileURLWithPath: path)

    do {
        player = try AVAudioPlayer(contentsOf: url)
        player?.play()
    } catch {
        print("Couldn't load sound")
    }
}
