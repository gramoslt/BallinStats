//
//  PlayerDetailsViewModelTests.swift
//  BallinStatsTests
//
//  Created by Gerardo Leal on 26/09/23.
//

import XCTest
import SwiftUI
@testable import BallinStats

final class PlayerDetailsViewModelTests: XCTestCase {
    var data: Data?
    var error: Error?
    var response: URLResponse?
    var urlString: String = "https://www.balldontlie.io/api/v1/season_averages?player_ids[]=237"

    func test_ViewModel_Not_Nil_Calculated_Variables() async {
        let sut = await PlayerDetailsViewModel(player: Player.mock, networkManager: NetworkManager(session: URLSessionMock()))
        let heightFeet = await sut.heightFeet
        let weightPounds = await sut.weightPounds
        let heightInches = await sut.heightInches
        let backgroundColor = await sut.backgroundColor
        let expectedBackgroundColor = Color("\(Player.mock.team.abbreviation)Color")

        XCTAssertNotNil(heightFeet)
        XCTAssertNotNil(weightPounds)
        XCTAssertNotNil(heightInches)
        XCTAssertEqual(backgroundColor, expectedBackgroundColor)
    }

    func test_ViewModel_Calculated_Variables_Are_Nil() async {
        let tempPlayer = Player(
            id: 1,
            firstName: "",
            lastName: "",
            position: "",
            heightFeet: nil,
            heightInches: nil,
            weightPounds: nil,
            team: TeamDetails.mockATL
        )
        let sut = await PlayerDetailsViewModel(player: tempPlayer, networkManager: NetworkManager(session: URLSessionMock()))
        let heightFeet = await sut.heightFeet
        let weightPounds = await sut.weightPounds
        let heightInches = await sut.heightInches

        XCTAssertEqual(heightFeet, PlayerDetailsViewConstants.notAvailableString)
        XCTAssertEqual(weightPounds, PlayerDetailsViewConstants.notAvailableString)
        XCTAssertEqual(heightInches, PlayerDetailsViewConstants.notAvailableString)
    }

    func test_successful_fetch_player_stats() async {
        data = """
        {
          "data": [
            {
              "player_id":237,
              "reb":8.54,
              "ast":7.38,
              "pts":26.97,
            }
          ]
        }
        """.data(using: .utf8)
        response = MockResponse.createResponse(urlString: urlString, statusCode: 200)
        let urlSessionMock = URLSessionMock(data: data, response: response)

        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayerDetailsViewModel(player: Player.mock, networkManager: networkManager)

        await sut.fetchPlayerStats()
        let playerPts = await sut.ppg
        let playerAst = await sut.apg
        let playerReb = await sut.rpg

        XCTAssertEqual(playerPts, PlayerStats.mock.pts)
        XCTAssertEqual(playerAst, PlayerStats.mock.ast)
        XCTAssertEqual(playerReb, PlayerStats.mock.reb)
    }

    func test_fetch_player_stats_not_found() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 404)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayerDetailsViewModel(player: Player.mock, networkManager: networkManager)

        await sut.fetchPlayerStats()
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.notFoundText)
    }

    func test_fetch_player_stats_bad_request() async {

        response = MockResponse.createResponse(urlString: urlString, statusCode: 400)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayerDetailsViewModel(player: Player.mock, networkManager: networkManager)

        await sut.fetchPlayerStats()
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.badRequestText)
    }

    func test_fetch_player_stats_server_error() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 429)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayerDetailsViewModel(player: Player.mock, networkManager: networkManager)

        await sut.fetchPlayerStats()
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.serverErrorText)
    }

    func test_fetch_player_stats_unknown_error() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 701)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await PlayerDetailsViewModel(player: Player.mock, networkManager: networkManager)

        await sut.fetchPlayerStats()
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.unknownErrorText)
    }
}
