//
//  FIlesManipulation.swift
//  MarvelCharactersTests
//
//  Created by Vitor Conceicao on 20/01/22.
//

import Foundation
class FilesManipulation {
    
    static let shared = FilesManipulation()
    
    func loadJsonFile(name: String) -> Data {
        guard let dataURL = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") else {
            fatalError("Could not find \(name).json")
        }
        
        guard let jsonString = try? String(contentsOfFile: dataURL, encoding: .utf8) else {
            fatalError("Unable to convert \(name).json to String")
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert string json to Data")
        }
        
        return jsonData
    }
}
