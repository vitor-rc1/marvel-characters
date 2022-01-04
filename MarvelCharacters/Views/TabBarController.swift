//
//  TabBarController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllersTabBar()
    }
    
    private func controllersTabBar() {
        let characterVC = CharactersViewController()
        let favoritesVC = FavoritesViewController()
        
        characterVC.title = "Characters"
        favoritesVC.title = "Favorites"
        
        characterVC.tabBarItem.image = UIImage(systemName: "person.3")
        favoritesVC.tabBarItem.image = UIImage(systemName: "star")
        
        self.setViewControllers([characterVC, favoritesVC], animated: false)
    }

}
