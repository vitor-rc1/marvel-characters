//
//  MarvelAPIResponse.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import Foundation

struct MarvelResponse: Codable {
    let code: Int
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset: Int
    let results: [MarvelCharacter]
    let total: Int
}
