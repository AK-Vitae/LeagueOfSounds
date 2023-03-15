//
//  ChampionCell.swift
//  LeagueOfSounds
//
//  Created by Ramadugu, Akshith on 3/1/23.
//

import UIKit
import SwiftUI

class ChampionCell: UICollectionViewCell {
    static let reuseID = "ChampionCell"
    let championImageView = ChampionImageView(frame: .zero)
    let championLabel   = TitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(champion: Champion) {
        if #available(iOS 16.0, *) {
            contentConfiguration = UIHostingConfiguration {
                ChampionImageSwiftUIView(champion: champion)
            }
        } else {
            championImageView.downloadImage(for: champion.id)
            championLabel.text = champion.name
        }
    }
    
    private func configure() {
        addSubviews(championImageView, championLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            championImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            championImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            championImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            championImageView.heightAnchor.constraint(equalTo: championImageView.widthAnchor),
            
            championLabel.topAnchor.constraint(equalTo: championImageView.bottomAnchor, constant: 12),
            championLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            championLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            championLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
