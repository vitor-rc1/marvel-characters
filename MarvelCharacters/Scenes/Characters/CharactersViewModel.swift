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

    private var currentPage: Int = 0
    private var characters: [MarvelCharacter] = []

    // MARK: - Properties

    weak var delegate: CharactersViewModelDelegate?

    // MARK: - Inits

    init(service: MarvelAPIProtocol) {
        self.service = service
    }

    private func getCharacters(with page: Int) {
        service.get(page: page, orderBy: "name") { [weak self] (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
            switch result {
            case let .failure(error):
                switch error {
                case .network(let errorMessage), .decodeFail(let errorMessage), .invalidURL(let errorMessage):
                    DispatchQueue.main.async {
                        self?.delegate?.showError(message: errorMessage ?? "")
                    }
                }

            case let .success(response):
                self?.characters += response.data.results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadCharacters()
                }
            }
        }
    }
}

extension CharactersViewModel: CharactersViewModelProtocol {
    func getCharactersCount() -> Int {
        characters.count
    }

    func getCharacter(index: Int) -> MarvelCharacter {
        characters[index]
    }

    func getCharacters() {
        getCharacters(with: currentPage)
    }

    func getNextCharactersPage() {
        currentPage += 1
        getCharacters(with: currentPage)
    }
}
