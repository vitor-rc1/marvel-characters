//
//  MarvelAPI.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 03/01/22.
//

import Foundation
import SwiftHash

public class MarvelAPI {
    private let baseURL = "https://gateway.marvel.com/v1/public/characters?"
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
    
    func get(page: Int = 0, callback: @escaping (Result<MarvelResponse, ServiceError>) -> Void) {
        let offset = limit * page
        let path = "\(baseURL)orderBy=name&\(getCredentials())&offset=\(offset)&limit=\(limit)"
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
                let marvelResponse = try decode.decode(MarvelResponse.self, from: data)
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
