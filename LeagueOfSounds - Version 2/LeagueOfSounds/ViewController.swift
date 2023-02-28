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
        view.backgroundColor = .systemMint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getChampions()
    }
    
    func getApiVersions() {
        Task {
            do {
                let apiVersions = try await NetworkManager.shared.getApiVersions()
                if let currentApiVersion = apiVersions.first {
                    print(currentApiVersion)
                }
            } catch {
                if let gfError = error as? LolError {
                    print(gfError.rawValue)
                } else {
                    print("Error")
                }
            }
        }
    }
    
    func getChampions() {
        Task {
            do {
                // 1. Fetch Api Version
                let apiVersions = try await NetworkManager.shared.getApiVersions()
                
                // 2. Use the latest Api Version to fetch all the champions
                let champions = try await NetworkManager.shared.getChampions(for: apiVersions.first)
                
                let championsArray = champions.getChampionsAsSortedArray()
                for champion in championsArray {
                    print(champion.name)
                }
            } catch {
                if let gfError = error as? LolError {
                    print(gfError.rawValue)
                } else {
                    print("Error")
                }
            }
        }
    }
}

