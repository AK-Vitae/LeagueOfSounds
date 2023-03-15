//
//  ViewController.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/27/23.
//

import UIKit

class ViewController: UIViewController {
    
    var apiVersions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .systemMint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getChampions()
    }
    
    func getChampions() {
        Task {
            do {
                // 1. Fetch Api Version
                let apiVersions = try await NetworkManager.shared.getApiVersions()
                
                // 2. Use the latest Api Version to fetch all the champions
                let latestApiVersion = apiVersions.first
                var champions = try await NetworkManager.shared.getChampions(for: latestApiVersion)
                
                let championsArray = champions.championsSortedArray
                for champion in championsArray {
                    print(champion.name)
                    guard let image = await NetworkManager.shared.downloadImage(currentApiVersion: latestApiVersion, for: champion.id) else {
                        continue
                    }
                    DispatchQueue.main.async {
                        self.view.backgroundColor = UIColor(patternImage: image)
                    }
                }
            } catch {
                if let lolError = error as? LolError {
                    print(lolError.rawValue)
                } else {
                    print("Error")
                }
            }
        }
    }
}


