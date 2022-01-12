//
//  MarvelAPI.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 03/01/22.
//

import Foundation
import SwiftHash

public class MarvelAPI {
    private let baseURL = "https://gateway.marvel.com/v1/public/characters"
    private var publicKey: String = ""
    private var privateKey: String = ""
    
    private let limit = 20
    
    init(){
        if
            let publicKey = ProcessInfo.processInfo.environment["publicKey"],
            let privateKey = ProcessInfo.processInfo.environment["privateKey"]
        {
            self.publicKey = publicKey
            self.privateKey = privateKey
        }
    }
    
    func get<T: Codable>(
        page: Int = 0,
        orderBy: String = "name",
        callback: @escaping (Result<T, ServiceError>
        ) -> Void) {
        let offset = limit * page
        let path = "\(baseURL)?orderBy=\(orderBy)&\(getCredentials())&offset=\(offset)&limit=\(limit)"
        
        network(path: path, callback: callback)
    }
    
    func getById<T: Codable>(
        id: Int,
        specification: String = "",
        callback: @escaping (Result<T, ServiceError>
        ) -> Void) {
        
        var path: String = "\(baseURL)/\(id)"
        
        if specification.isEmpty {
            path += "?\(getCredentials())"
        } else {
            path += "/\(specification)?\(getCredentials())"
        }
        
        network(path: path, callback: callback)
    }
    
    private func network<T: Codable>(path: String, callback: @escaping (Result<T, ServiceError>
    ) -> Void) {
        guard let url = URL(string: path) else {
            callback(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decode = JSONDecoder()
            guard let data = data else {
                callback(.failure(.network(error)))
                return
            }
            
            do {
                let marvelResponse = try decode.decode(T.self, from: data)
                callback(.success(marvelResponse))
            } catch  {
                callback(.failure(.decodeFail(error)))
            }
            
        }
        task.resume()
    }
    
    private func getCredentials() -> String{
        let nowTimestamp = Date().timeIntervalSince1970.description
        let hash = MD5(nowTimestamp+privateKey+publicKey).lowercased()
        return "ts=\(nowTimestamp)&apikey=\(publicKey)&hash=\(hash)"
    }
}
