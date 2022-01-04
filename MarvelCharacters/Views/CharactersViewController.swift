//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 03/01/22.
//

import UIKit

class CharactersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let service = MarvelAPI()
        service.get { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(data):
                print(data)
            }
        }
    }

}
