//
//  CharactersConfigurator.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 30/03/23.
//

import Foundation

final class CharactersConfigurator {
    func configure() -> CharactersViewController {
        let service = MarvelAPI()
        let viewModel = CharactersViewModel(service: service)
        let viewController = CharactersViewController(viewModel: viewModel)

        viewModel.delegate = viewController

        return viewController
    }
}
