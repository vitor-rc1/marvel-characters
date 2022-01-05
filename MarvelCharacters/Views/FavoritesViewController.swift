//
//  FavoritesViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Favorites"
    }
    
}
