//
//  PlayerDetailsViewModelTests.swift
//  BallinStatsTests
//
//  Created by Gerardo Leal on 26/09/23.
//

import XCTest
@testable import BallinStats

final class PlayerDetailsViewModelTests: XCTestCase {
    var data: Data?
    var error: Error?
    var response: URLResponse?

    func test_ViewModel_Not_Nil_Calculated_Variables() async {
        let sut = await PlayerDetailsViewModel(player: Player.mock, networkManager: NetworkManager(session: URLSessionMock()))
        let heightFeet = await sut.heightFeet
        let weightPounds = await sut.weightPounds
        let heightInches = await sut.heightInches

        XCTAssertNotNil(heightFeet)
        XCTAssertNotNil(weightPounds)
        XCTAssertNotNil(heightInches)
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
        response = HTTPURLResponse(
            url: URL(string: "https://www.balldontlie.io/api/v1/season_averages?player_ids[]=237")!,
            statusCode: 200,
            httpVersion: "1.1",
            headerFields: nil
        )!
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
        response = HTTPURLResponse(
            url: URL(string: "https://www.balldontlie.io/api/v1/season_averages?player_ids[]=237")!,
            statusCode: 404,
            httpVersion: "1.1",
            headerFields: nil
        )!
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

        response = HTTPURLResponse(
            url: URL(string: "https://www.balldontlie.io/api/v1/season_averages?player_ids[]=237")!,
            statusCode: 400,
            httpVersion: "1.1",
            headerFields: nil
        )!
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
        response = HTTPURLResponse(
            url: URL(string: "https://www.balldontlie.io/api/v1/season_averages?player_ids[]=237")!,
            statusCode: 429,
            httpVersion: "1.1",
            headerFields: nil
        )!
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
        response = HTTPURLResponse(
            url: URL(string: "https://www.balldontlie.io/api/v1/season_averages?player_ids[]=237")!,
            statusCode: 700,
            httpVersion: "1.1",
            headerFields: nil
        )!
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
