//
//  MockMarvelAPI.swift
//  MarvelCharactersTests
//
//  Created by Vitor Conceicao on 20/01/22.
//

import Foundation
@testable import MarvelCharacters

class MockMarvelAPI: MarvelAPIProtocol {
    private let fileManipulation = FilesManipulation.shared
    var filename: String = ""
    var isGetCalled: Bool = false
    var isGetByIdCalled: Bool = false
    var customError: ServiceError!
    
    
    func get<T: Codable>(
        page: Int = 0,
        orderBy: String = "name",
        callback: @escaping (Result<T, ServiceError>) -> Void) {
            if customError == nil {
                isGetCalled = true
                decodeData(callback: callback)
            } else {
                callback(.failure(customError))
            }
            
    }
    
    func getById<T: Codable>(
        id: Int,
        specification: String,
        callback: @escaping (Result<T, ServiceError>) -> Void) {
            if customError == nil {
                isGetByIdCalled = true
                decodeData(callback: callback)
            } else {
                callback(.failure(customError))
            }
    }
    
    private func decodeData<T: Codable>(callback: @escaping (Result<T, ServiceError>) -> Void) {
        do {
            let decode = JSONDecoder()
            let data = fileManipulation.loadJsonFile(name: filename)
            let marvelResponse = try decode.decode(T.self, from: data)
            callback(.success(marvelResponse))
        } catch {
            callback(.failure(.decodeFail(error.localizedDescription)))
        }
    }
    
}
