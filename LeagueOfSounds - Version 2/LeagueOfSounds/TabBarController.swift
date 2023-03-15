//
//  TabBarController.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 3/15/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        
        viewControllers = [createChampionCollectionViewController(), createFavoritesListNavigationController()]
    }
    
    func createChampionCollectionViewController() -> UINavigationController {
        let searchViewController = ChampionCollectionViewController()
        searchViewController.title = "Champions"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchViewController)
    }
    
    func createFavoritesListNavigationController() -> UINavigationController {
        let favoritesListViewController = ChampionCollectionViewController()
        favoritesListViewController.title = "Favorites"
        favoritesListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListViewController)
    }
}
