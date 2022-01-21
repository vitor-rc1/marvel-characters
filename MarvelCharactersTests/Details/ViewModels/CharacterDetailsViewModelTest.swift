//
//  CharacterDetailsViewModelTest.swift
//  MarvelCharactersTests
//
//  Created by Vitor Conceicao on 20/01/22.
//

import XCTest
@testable import MarvelCharacters

class CharacterDetailsViewModelTest: XCTestCase {
    var serviceAPI: MockMarvelAPI!
    var viewModel: CharactersDetailsViewModel!

    override func setUp() {
        serviceAPI = MockMarvelAPI()
        viewModel = CharactersDetailsViewModel(service: serviceAPI)
    }
    
    override func tearDown() {
        serviceAPI = nil
        viewModel = nil
    }

    func testCharactersViewModelFetchCharacter_WhenCalled_ReturnCharacterById() throws {
        serviceAPI.filename = "MarvelAPICharacterByIdResponse"
        XCTAssert(!serviceAPI.isGetByIdCalled)
        viewModel.fetchCharacter(id: 1011334) { character in
            XCTAssertEqual(character.id, 1011334)
            XCTAssertEqual(character.name, "3-D Man")
            XCTAssert(self.serviceAPI.isGetByIdCalled)
        }
    }
    
    func testCharactersViewModelFetchCharacter_WhenCalledWithSpecification_ReturnCharacterComics() throws {
        serviceAPI.filename = "MarvelAPICharacterComics"
        XCTAssert(!serviceAPI.isGetByIdCalled)
        viewModel.fetchCharacterMidias(id: 1011334, specification: "comics") { comics in
            guard let firstComic = comics.first else {
                XCTFail("Comics not returned")
                return
            }
            XCTAssertEqual(comics.count, 12)
            XCTAssertEqual(firstComic.id, 22506)
            XCTAssertEqual(firstComic.title, "Avengers: The Initiative (2007) #19")
            XCTAssert(self.serviceAPI.isGetByIdCalled)
        }
    }
    
    func testCharactersViewModelFetchCharacter_WhenCalledWithSpecification_ReturnCharacterSeries() throws {
        serviceAPI.filename = "MarvelAPICharacterSeries"
        XCTAssert(!serviceAPI.isGetByIdCalled)
        viewModel.fetchCharacterMidias(id: 1011334, specification: "series") { series in
            guard let firstSerie = series.first else {
                XCTFail("Series not returned")
                return
            }
            XCTAssertEqual(series.count, 3)
            XCTAssertEqual(firstSerie.id, 1945)
            XCTAssertEqual(firstSerie.title, "Avengers: The Initiative (2007 - 2010)")
            XCTAssert(self.serviceAPI.isGetByIdCalled)
        }
    }
    
    func testCharacterDetailsViewModelFetchCharacter_WhenReturnError_CallOnErrorHandlig() throws {
        let expectation = self.expectation(description: "Call onErrorHandling")
        let expectedMessage = "The passed API key is invalid."

        serviceAPI.customError = .network(expectedMessage)

        viewModel.onErrorHandling = { message in
            XCTAssertEqual(message, expectedMessage)
            expectation.fulfill()
        }

        XCTAssert(!serviceAPI.isGetCalled)
        viewModel.fetchCharacter(id: 1011334) { character in
            XCTFail("Callback should not be called")
        }

        self.wait(for: [expectation], timeout: 5)

    }
    
    func testCharacterDetailsViewModelFetchCharacterMidia_WhenReturnError_CallOnErrorHandlig() throws {
        let expectation = self.expectation(description: "Call onErrorHandling")
        let expectedMessage = "The passed API key is invalid."

        serviceAPI.customError = .network(expectedMessage)

        viewModel.onErrorHandling = { message in
            XCTAssertEqual(message, expectedMessage)
            expectation.fulfill()
        }

        XCTAssert(!serviceAPI.isGetCalled)
        viewModel.fetchCharacterMidias(id: 1011334, specification: "comics") { character in
            XCTFail("Callback should not be called")
        }

        self.wait(for: [expectation], timeout: 5)

    }

}
