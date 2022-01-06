//
//  CharactersViewModel.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import Foundation

struct CharactersViewModel {
    
    private let service: MarvelAPI!
    
    var onErrorHandling: ((String?) -> Void)?
    
    init(service: MarvelAPI = MarvelAPI()) {
        self.service = service
    }
    
    func fetchCharacters(page: Int = 0, callback: @escaping ([MarvelCharacter]) -> Void){
        service.get(page: page) { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(data):
                let characters = data.data.results
                callback(characters)
            }
        }
    }
}
