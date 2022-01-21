//
//  MarvelAPITest.swift
//  MarvelCharactersTests
//
//  Created by Vitor Conceicao on 18/01/22.
//

import XCTest
import Mocker
@testable import MarvelCharacters

class MarvelAPITest: XCTestCase {
    
    var serviceAPI: MarvelAPI!
    var baseURL: String!
    let fileManipulation = FilesManipulation.shared
    
    override func setUp() {
        serviceAPI = MarvelAPI()
        baseURL = serviceAPI.baseURL
    }
    
    override func tearDown() {
        serviceAPI = nil
        baseURL = nil
        MockURLProtocol.stubResponseData = nil
    }
    
    func testMarvelAPIGet_WhenCalled_ReturnCharacters() throws {
        // Arrange
        registerMock(urlString: baseURL, mockFileName: "MarvelAPICharactersResponse", statusCode: 200)
        
        let expectation = self.expectation(description: "Get all characters data")
        
        // Act
        serviceAPI.get(page: 0, orderBy: "name") { (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
            // Assert
            switch result {
            case .success(let response):
                XCTAssertEqual(response.code, 200)
                XCTAssertEqual(response.data.results.count, 20)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testMarvelAPIGetById_WhenCalled_ReturnCharacterById() throws {
        // Arrange
        let characterId = 1011334
        let path = "\(baseURL!)/\(characterId)"
        registerMock(urlString: path, mockFileName: "MarvelAPICharacterByIdResponse", statusCode: 200)
        
        let expectation = self.expectation(description: "Get character data by id")
        
        // Act
        serviceAPI.getById(id: characterId) { (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
            // Assert
            switch result {
            case .success(let response):
                guard let character = response.data.results.first else {
                    XCTFail("Character not returned")
                    return
                }
                XCTAssertEqual(response.code, 200)
                XCTAssertEqual(response.data.results.count, 1)
                XCTAssertEqual(character.id, 1011334)
                XCTAssertEqual(character.name, "3-D Man")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testMarvelAPIGetById_WhenCalledWIthSpecification_ReturnCharacterMidia() throws {
        // Arrange
        let characterId = 1011334
        let path = "\(baseURL!)/\(characterId)/comics"
        registerMock(urlString: path, mockFileName: "MarvelAPICharacterComics", statusCode: 200)
        let expectation = self.expectation(description: "Get character comics data")
        
        // Act
        serviceAPI.getById(id: 1011334, specification: "comics") { (result: Result<MarvelResponse<MarvelCharacterMidia>, ServiceError>) in
            // Assert
            switch result {
            case .success(let response):
                guard let firstComic = response.data.results.first else {
                    XCTFail("Comics not returned")
                    return
                }
                XCTAssertEqual(response.code, 200)
                XCTAssertEqual(response.data.results.count, 12)
                XCTAssertEqual(firstComic.id, 22506)
                XCTAssertEqual(firstComic.title, "Avengers: The Initiative (2007) #19")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testMarvelAPINetwork_WhenCalledWithInvalidURL_ReturnInvalidURL() throws {
        // Arrange
        let expectation = self.expectation(description: "Return invalidURL error")
        
        serviceAPI.network(path: "") { (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
            // Assert
            switch result {
            case .success(let result):
                XCTFail("Network should not return success when URL is invalid. \(result)")
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL("Invalid URL"))
            }
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testMarvelAPINetwork_WhenReturnNot200StatusCode_ReturnNetworkError() throws {
        // Arrange
        let expectation = self.expectation(description: "Return network error")
        registerMock(urlString: baseURL, mockFileName: "MarvelAPIInvalidCredentialsResponse", statusCode: 404)
        serviceAPI.network(path: baseURL) { (result: Result<MarvelResponse<MarvelCharacter>, ServiceError>) in
            // Assert
            switch result {
            case .success(let result):
                XCTFail("Network should not return success when code isn`t 200. \(result)")
            case .failure(let error):
                XCTAssertEqual(error, .network("Network error"))
            }
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    private func registerMock(urlString: String, mockFileName: String, statusCode: Int) {
        if let url = URL(string: urlString) {
            let mockResponse = fileManipulation.loadJsonFile(name: mockFileName)
            let mockService = Mock(url: url, ignoreQuery: true, dataType: .json, statusCode: statusCode,
                                   data: [Mock.HTTPMethod.get : mockResponse])
            mockService.register()
        } else {
            XCTFail("Need a url to mock")
        }
    }
    
    
}
