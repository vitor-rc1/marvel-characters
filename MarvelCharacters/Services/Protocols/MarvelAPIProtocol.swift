//
//  MarvelAPIProtocol.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 19/01/22.
//

import Foundation

protocol MarvelAPIProtocol {
    func get<T: Codable>(
        page: Int,
        orderBy: String,
        callback: @escaping (Result<T, ServiceError>
        ) -> Void)
    
    func getById<T: Codable>(
        id: Int,
        specification: String,
        callback: @escaping (Result<T, ServiceError>
        ) -> Void)
}
