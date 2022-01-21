//
//  CharactersViewModel.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import Foundation

public struct CharactersViewModel {
    
    private let service: MarvelAPIProtocol!
    
    var onErrorHandling: ((String?) -> Void)?
    
    init(service: MarvelAPIProtocol = MarvelAPI()) {
        self.service = service
    }
    
    func fetchCharacters(page: Int = 0, callback: @escaping ([MarvelCharacter]) -> Void){
        service.get(page: page, orderBy: "name") { (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
            switch result {
            case let .failure(error):
                switch error {
                case .network(let errorMessage),
                        .decodeFail(let errorMessage),
                        .invalidURL(let errorMessage):
                    onErrorHandling?(errorMessage)
                }
            case let .success(response):
                callback(response.data.results)
            }
        }
    }
}
