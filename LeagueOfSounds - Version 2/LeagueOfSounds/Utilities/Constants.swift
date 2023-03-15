//
//  Constants.swift
//  LeagueOfSounds
//
//  Created by Ramadugu, Akshith on 3/1/23.
//

import UIKit

enum Constants {
    static let defaultApiVersion = "13.4.1"
}

enum SFSymbols {
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let repos = UIImage(systemName: "folder")
    static let gists = UIImage(systemName: "text.alignleft")
    static let followers = UIImage(systemName: "heart")
    static let following = UIImage(systemName: "person.2")
    static let checkmarkCircle = UIImage(systemName: "checkmark.circle")
    static let person = UIImage(systemName: "person")
    static let person3 = UIImage(systemName: "person.3")
}

enum Images {
    static let placeholder = UIImage(named: "placeholder")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")
    static let logoNeutral = UIImage(named: "lol-logo-neutral")
    static let logoGold = UIImage(named: "lol-logo-gold")
}

enum SoundOption {
    static let pick = "Pick"
    static let ban = "Ban"
    static let taunt = "Taunt"
    static let laugh = "Laugh"

    static let allValues = [pick, ban, taunt, laugh]
}
