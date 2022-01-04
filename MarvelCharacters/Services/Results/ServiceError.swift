//
//  ServiceError.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 03/01/22.
//

import Foundation

public enum ServiceError: Error {
    case invalidURL
    case decodeFail(Error)
    case network(Error?)
}
