//
//  ChampionImageView.swift
//  LeagueOfSounds
//
//  Created by Ramadugu, Akshith on 3/1/23.
//

import UIKit

class ChampionImageView: UIImageView {
    let placeholderImage = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(currentApiVersion: String? = nil, for champion: String) {
        Task {
            image = await NetworkManager.shared.downloadImage(currentApiVersion: currentApiVersion, for: champion) ?? placeholderImage
        }
    }
}

