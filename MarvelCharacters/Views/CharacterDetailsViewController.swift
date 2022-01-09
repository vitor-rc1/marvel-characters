//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 08/01/22.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    private var viewModel: CharactersDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharactersDetailsViewModel()
        
        self.view.backgroundColor = .white
        
    }

}
