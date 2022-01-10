//
//  MarvelAPIResponse.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let code: Int
    let data: MarvelData<T>
}

struct MarvelData<T: Codable>: Codable {
    let offset: Int
    let results: [T]
    let total: Int
}
