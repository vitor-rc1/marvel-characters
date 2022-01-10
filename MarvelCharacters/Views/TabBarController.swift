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
        let characterVC = CharactersViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let favoritesVC = FavoritesViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        characterVC.title = "Characters"
        favoritesVC.title = "Favorites"
        
        characterVC.tabBarItem.image = UIImage(systemName: "person.3")
        favoritesVC.tabBarItem.image = UIImage(systemName: "star")
        
        self.setViewControllers([characterVC, favoritesVC], animated: false)
    }

}
