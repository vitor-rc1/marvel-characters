//
//  CharactersViewModel.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import Foundation

struct CharactersViewModel {
    
    private let service: MarvelAPI!
    
    var onErrorHandling: ((String) -> Void)?
    
    init(service: MarvelAPI = MarvelAPI()) {
        self.service = service
    }
    
    func fetchCharacters(page: Int = 0, callback: @escaping ([[String: Any]]) -> Void){
        service.get(page: page) { (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
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
                        "description": character.description,
                        "name": character.name,
                        "url": character.thumbnail.url
                    ] as [String : Any]
                    charactersDictionary.append(dictionary)
                }
                
                callback(charactersDictionary)
                
            }
        }
    }
}
