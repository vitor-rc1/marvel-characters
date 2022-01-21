//
//  CharactersViewModelTest.swift
//  MarvelCharactersTests
//
//  Created by Vitor Conceicao on 20/01/22.
//

import XCTest

@testable import MarvelCharacters

class CharactersViewModelTest: XCTestCase {
    var serviceAPI: MockMarvelAPI!
    var viewModel: CharactersViewModel!
    
    override func setUp() {
        serviceAPI = MockMarvelAPI()
        viewModel = CharactersViewModel(service: serviceAPI)
    }
    
    override func tearDown() {
        serviceAPI = nil
        viewModel = nil
    }
    
    func testCharactersViewModelFetchCharacters_WhenCalled_ReturnAllCharacters() throws {
        let expectation = self.expectation(description: "Get all characters")
        
        serviceAPI.filename = "MarvelAPICharactersResponse"
        XCTAssert(!serviceAPI.isGetCalled)
        viewModel.fetchCharacters { characters in
            guard let lastCharacter = characters.last else {
                XCTFail("No characters have been returned.")
                return
            }
            XCTAssertEqual(characters.count, 20)
            XCTAssertEqual(lastCharacter.id, 1011136)
            XCTAssertEqual(lastCharacter.name, "Air-Walker (Gabriel Lan)")
            XCTAssert(self.serviceAPI.isGetCalled)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testCharactersViewModelFetchCharacters_WhenReturnError_CallOnErrorHandlig() throws {
        let expectation = self.expectation(description: "Call onErrorHandling")
        let expectedMessage = "Invalid URL"

        serviceAPI.customError = .invalidURL(expectedMessage)

        viewModel.onErrorHandling = { message in
            XCTAssertEqual(message, expectedMessage)
            expectation.fulfill()
        }

        XCTAssert(!serviceAPI.isGetCalled)
        viewModel.fetchCharacters { characters in
            XCTFail("Callback should not be called")
        }

        self.wait(for: [expectation], timeout: 5)

    }
    
}
