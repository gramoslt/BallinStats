//
//  PlayersTabViewModelTests.swift
//  BallinStatsTests
//
//  Created by Gerardo Leal on 06/10/23.
//

import XCTest
@testable import BallinStats

final class PlayersTabViewModelTests: XCTestCase {
    var data: Data?
    var error: Error?
    var response: URLResponse?
    var urlString: String = "https://www.balldontlie.io/api/v1/players?page=1"

    func test_successful_load_more_players() async {
        data = """
        {
          "data": [
            {
                  "id":237,
                  "first_name":"LeBron",
                  "last_name":"James",
                  "position":"F",
                  "height_feet": 6,
                  "height_inches": 8,
                  "weight_pounds": 250,
                  "team":{
                    "id":14,
                    "abbreviation":"LAL",
                    "city":"Los Angeles",
                    "conference":"West",
                    "division":"Pacific",
                    "full_name":"Los Angeles Lakers",
                    "name":"Lakers"
                  }
                },
            {
                  "id": 434,
                  "first_name": "Jayson",
                  "height_feet": 6,
                  "height_inches": 8,
                  "last_name": "Tatum",
                  "position": "F",
                  "team": {
                    "id": 2,
                    "abbreviation": "BOS",
                    "city": "Boston",
                    "conference": "East",
                    "division": "Atlantic",
                    "full_name": "Boston Celtics",
                    "name": "Celtics"
                  },
                  "weight_pounds": 208
                },
            ],
        "meta":{"total_pages":2,"current_page":1,"total_count":45}}
        """.data(using: .utf8)
        response = MockResponse.createResponse(urlString: urlString, statusCode: 200)
        let urlSessionMock = URLSessionMock(data: data, response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayersTabViewModel(networkManager: networkManager)
        let expectedResult = [Player.mockLebron, Player.mockTatum]

        await sut.loadMore()
        let players = await sut.players

        XCTAssertEqual(players, expectedResult)
    }

    func test_fetch_players_not_found() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 404)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayersTabViewModel(networkManager: networkManager)

        await sut.fetchPlayers(for: "")
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.notFoundText)
    }

    func test_fetch_players_bad_request() async {

        response = MockResponse.createResponse(urlString: urlString, statusCode: 400)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayersTabViewModel(networkManager: networkManager)

        await sut.fetchPlayers(for: "")
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.badRequestText)
    }

    func test_fetch_players_server_error() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 429)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayersTabViewModel(networkManager: networkManager)

        await sut.fetchPlayers(for: "")
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.serverErrorText)
    }

    func test_fetch_players_unknown_error() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 701)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayersTabViewModel(networkManager: networkManager)

        await sut.fetchPlayers(for: "")
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.unknownErrorText)
    }
}
