//
//  Character.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import Foundation

struct MarvelCharacter: Codable {
    let id: Int
    let description: String
    let name: String
    let thumbnail: Thumbnail
}
