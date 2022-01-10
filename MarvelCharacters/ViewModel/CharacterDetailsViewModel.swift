//
//  CharacterDetailsViewModel.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 09/01/22.
//

import Foundation

struct CharactersDetailsViewModel {
    
    private let service: MarvelAPI!
    
    var onErrorHandling: ((String) -> Void)?
    
    init(service: MarvelAPI = MarvelAPI()) {
        self.service = service
    }
    
    func fetchCharacter(id: Int, callback: @escaping ([String: Any]) -> Void){
        service.getById(id: id) { (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
            switch result {
            case let .failure(error):
                switch error {
                case .network(let error):
                    if let errorMessage = error?.localizedDescription {
                        onErrorHandling?(errorMessage)
                    }
                case .decodeFail(let error):
                    print(error.localizedDescription)
                case .invalidURL:
                    print("Invalid URL")
                }
            case let .success(data):
                let character = data.data.results[0]
                let characterDictionary: [String: Any] = [
                        "id": character.id,
                        "description": character.description,
                        "name": character.name,
                        "url": character.thumbnail.url
                    ] as [String : Any]
                callback(characterDictionary)
                
            }
        }
    }
    
    func fetchCharacterMidias(id: Int, specification: String, callback: @escaping ([[String: Any]]) -> Void){
        service.getById(id: id, specification: specification) { (result: Result<MarvelResponse<MarvelCharacterMidia>, ServiceError>) in
            switch result {
            case let .failure(error):
                switch error {
                case .network(let error):
                    if let errorMessage = error?.localizedDescription {
                        onErrorHandling?(errorMessage)
                    }
                case .decodeFail(let error):
                    print(error.localizedDescription)
                case .invalidURL:
                    print("Invalid URL")
                }
            case let .success(data):
                var charactersDictionary: [[String: Any]] = []
                for character in data.data.results {
                    let dictionary = [
                        "id": character.id,
                        "title": character.title,
                        "url": character.thumbnail.url
                    ] as [String : Any]
                    charactersDictionary.append(dictionary)
                }
                
                callback(charactersDictionary)
                
            }
        }
    }
    
}
