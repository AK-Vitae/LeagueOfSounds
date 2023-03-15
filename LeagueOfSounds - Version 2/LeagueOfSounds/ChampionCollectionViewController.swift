//
//  ChampionCollectionViewController.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/27/23.
//

import UIKit

class ChampionCollectionViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var champions: [Champion] = []
    var filteredChampions: [Champion] = []
    var apiVersions: [String] = []
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Champion>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getChampions()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ChampionCell.self, forCellWithReuseIdentifier: ChampionCell.reuseID)
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
                updateUI(with: championsArray)
            } catch {
                if let lolError = error as? LolError {
                    print(lolError.rawValue)
                } else {
                    print("Error")
                }
            }
        }
    }
    
    func updateUI(with champions: [Champion]) {
        self.champions.append(contentsOf: champions)
        self.updateData(on: self.champions)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Champion>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, champion) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChampionCell.reuseID, for: indexPath) as! ChampionCell
            cell.set(champion: champion)
            return cell
        })
    }
    
    func updateData(on champions: [Champion]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Champion>()
        snapshot.appendSections([.main])
        snapshot.appendItems(champions)
        print(champions.count)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension ChampionCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = !filteredChampions.isEmpty ? filteredChampions : champions
        let champion = activeArray[indexPath.item]
        
        let destinationViewController = ChampionDetailsViewController(champion: champion)
//        destinationViewController.delegate = self
        navigationController?.pushViewController(destinationViewController, animated: true)

    }
}



