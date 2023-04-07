//
//  CharactersViewModel.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import Foundation

public class CharactersViewModel {
    // MARK: - Private Properties
    private let service: MarvelAPIProtocol

    // MARK: - Properties

    weak var delegate: CharactersViewModelDelegate?

    // MARK: - Inits

    init(service: MarvelAPIProtocol) {
        self.service = service
    }
}

extension CharactersViewModel: CharactersViewModelProtocol {
    func fetchCharacters(page: Int = 0, callback: @escaping ([MarvelCharacter]) -> Void) {
        service.get(page: page, orderBy: "name") { [weak self] (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
            switch result {
            case let .failure(error):
                switch error {
                case .network(let errorMessage), .decodeFail(let errorMessage), .invalidURL(let errorMessage):
                    self?.delegate?.showError(message: errorMessage ?? "")
                }
            case let .success(response):
                callback(response.data.results)
            }
        }
    }
}
