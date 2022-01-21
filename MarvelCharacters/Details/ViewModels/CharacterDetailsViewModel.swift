//
//  CharacterDetailsViewModel.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 09/01/22.
//

import Foundation

struct CharactersDetailsViewModel {
    
    private let service: MarvelAPIProtocol!
    
    var onErrorHandling: ((String?) -> Void)?
    
    init(service: MarvelAPIProtocol = MarvelAPI()) {
        self.service = service
    }
    
    func fetchCharacter(id: Int, callback: @escaping (MarvelCharacter) -> Void){
        service.getById(id: id, specification: "") { (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
            switch result {
            case let .failure(error):
                switch error {
                case .network(let errorMessage),
                        .decodeFail(let errorMessage),
                        .invalidURL(let errorMessage):
                    onErrorHandling?(errorMessage)
                }
            case let .success(data):
                if let character = data.data.results.first {
                    callback(character)
                }
            }
        }
    }
    
    func fetchCharacterMidias(id: Int, specification: String, callback: @escaping ([MarvelCharacterMidia]) -> Void){
        service.getById(id: id, specification: specification) { (result: Result<MarvelResponse<MarvelCharacterMidia>, ServiceError>) in
            switch result {
            case let .failure(error):
                switch error {
                case .network(let errorMessage),
                        .decodeFail(let errorMessage),
                        .invalidURL(let errorMessage):
                    onErrorHandling?(errorMessage)
                }
            case let .success(data):
                callback(data.data.results)
            }
        }
    }
    
}
