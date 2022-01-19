//
//  ServiceError.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 03/01/22.
//

import Foundation

public enum ServiceError: Error, Equatable {
    public static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
            (.decodeFail, .decodeFail),
            (.network, .network):
            return true
        default:
            return false
        }
    }
    
    case invalidURL
    case decodeFail(Error)
    case network(Error?)
}
