//
//  TeamDetailsViewModelTests.swift
//  BallinStatsTests
//
//  Created by Gerardo Leal on 06/10/23.
//

import XCTest
import SwiftUI
@testable import BallinStats

final class TeamDetailsViewModelTests: XCTestCase {
    var data: Data?
    var error: Error?
    var response: URLResponse?
    var urlString: String = "https://www.balldontlie.io/api/v1/games?seasons[]=2020&team_ids[]=14"

    func test_fetch_5_games() async {
        data = """
        {
          "data": [
                    {
                      "id": 127803,
                      "home_team": {
                        "id": 2,
                        "abbreviation": "BOS",
                        "city": "Boston",
                        "conference": "East",
                        "division": "Atlantic",
                        "full_name": "Boston Celtics",
                        "name": "Celtics"
                      },
                      "home_team_score": 95,
                      "visitor_team": {
                        "id": 14,
                        "abbreviation": "LAL",
                        "city": "Los Angeles",
                        "conference": "West",
                        "division": "Pacific",
                        "full_name": "Los Angeles Lakers",
                        "name": "Lakers"
                      },
                      "visitor_team_score": 96
                    },
            {
              "id": 127503,
              "home_team": {
                "id": 14,
                "abbreviation": "LAL",
                "city": "Los Angeles",
                "conference": "West",
                "division": "Pacific",
                "full_name": "Los Angeles Lakers",
                "name": "Lakers"
              },
              "home_team_score": 109,
              "visitor_team": {
                "id": 13,
                "abbreviation": "LAC",
                "city": "LA",
                "conference": "West",
                "division": "Pacific",
                "full_name": "LA Clippers",
                "name": "Clippers"
              },
              "visitor_team_score": 116
            },
            {
              "id": 127520,
              "home_team": {
                "id": 14,
                "abbreviation": "LAL",
                "city": "Los Angeles",
                "conference": "West",
                "division": "Pacific",
                "full_name": "Los Angeles Lakers",
                "name": "Lakers"
              },
              "home_team_score": 138,
              "visitor_team": {
                "id": 7,
                "abbreviation": "DAL",
                "city": "Dallas",
                "conference": "West",
                "division": "Southwest",
                "full_name": "Dallas Mavericks",
                "name": "Mavericks"
              },
              "visitor_team_score": 115
            },
            {
              "id": 127541,
              "home_team": {
                "id": 14,
                "abbreviation": "LAL",
                "city": "Los Angeles",
                "conference": "West",
                "division": "Pacific",
                "full_name": "Los Angeles Lakers",
                "name": "Lakers"
              },
              "home_team_score": 127,
              "visitor_team": {
                "id": 18,
                "abbreviation": "MIN",
                "city": "Minnesota",
                "conference": "West",
                "division": "Northwest",
                "full_name": "Minnesota Timberwolves",
                "name": "Timberwolves"
              },
              "visitor_team_score": 91
            },
            {
              "id": 127545,
              "home_team": {
                "id": 14,
                "abbreviation": "LAL",
                "city": "Los Angeles",
                "conference": "West",
                "division": "Pacific",
                "full_name": "Los Angeles Lakers",
                "name": "Lakers"
              },
              "home_team_score": 107,
              "visitor_team": {
                "id": 25,
                "abbreviation": "POR",
                "city": "Portland",
                "conference": "West",
                "division": "Northwest",
                "full_name": "Portland Trail Blazers",
                "name": "Trail Blazers"
              },
              "visitor_team_score": 115
            }
            ],"meta": {
            "total_pages": 4,
            "current_page": 1,
            "total_count": 79
        }
        }
        """.data(using: .utf8)
        response = MockResponse.createResponse(urlString: urlString, statusCode: 200)
        let urlSessionMock = URLSessionMock(data: data, response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamDetailsViewModel(team: TeamDetails.mockLAL, networkManager: networkManager)
        await sut.setYear(year: 2022)

        let expectedGame = Game(
            id: 127803,
            homeTeam: TeamDetails.mockBOS,
            homeTeamScore: 95,
            visitorTeam: TeamDetails.mockLAL,
            visitorTeamScore: 96)
        let game = await sut.games[0]
        XCTAssertEqual(game, expectedGame)
    }

    func test_fetch_5_games_with_less_than_5() async {
        data = """
        {
          "data": [
                    {
                      "id": 127803,
                      "home_team": {
                        "id": 2,
                        "abbreviation": "BOS",
                        "city": "Boston",
                        "conference": "East",
                        "division": "Atlantic",
                        "full_name": "Boston Celtics",
                        "name": "Celtics"
                      },
                      "home_team_score": 95,
                      "visitor_team": {
                        "id": 14,
                        "abbreviation": "LAL",
                        "city": "Los Angeles",
                        "conference": "West",
                        "division": "Pacific",
                        "full_name": "Los Angeles Lakers",
                        "name": "Lakers"
                      },
                      "visitor_team_score": 96
                    }],
            "meta": {
            "total_pages": 4,
            "current_page": 1,
            "total_count": 79
            }
        }
        """.data(using: .utf8)
        response = MockResponse.createResponse(urlString: urlString, statusCode: 200)
        let urlSessionMock = URLSessionMock(data: data, response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamDetailsViewModel(team: TeamDetails.mockLAL, networkManager: networkManager)
        await sut.setYear(year: 2022)

        let expectedResult = [Game(
            id: 127803,
            homeTeam: TeamDetails.mockBOS,
            homeTeamScore: 95,
            visitorTeam: TeamDetails.mockLAL,
            visitorTeamScore: 96)]
        let games = await sut.games
        XCTAssertEqual(games, expectedResult)
    }

    func test_fetch_games_not_found() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 404)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamDetailsViewModel(team: TeamDetails.mockLAL, networkManager: networkManager)

        await sut.fetchFiveGames()
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.notFoundText)
    }

    func test_fetch_games_bad_request() async {

        response = MockResponse.createResponse(urlString: urlString, statusCode: 400)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamDetailsViewModel(team: TeamDetails.mockLAL, networkManager: networkManager)

        await sut.fetchFiveGames()
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.badRequestText)
    }

    func test_fetch_games_server_error() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 429)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamDetailsViewModel(team: TeamDetails.mockLAL, networkManager: networkManager)

        await sut.fetchFiveGames()
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.serverErrorText)
    }

    func test_fetch_games_unknown_error() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 701)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamDetailsViewModel(team: TeamDetails.mockLAL, networkManager: networkManager)

        await sut.fetchFiveGames()
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.unknownErrorText)
    }

    func test_button_assets_when_team_is_followed() async {
        let urlSessionMock = URLSessionMock()
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamDetailsViewModel(team: TeamDetails.mockLAL, networkManager: networkManager)

        await sut.setIsFollowed(isFollowed: true)
        let buttonText = await sut.buttonText
        let buttonIconString = await sut.buttonIconString

        XCTAssertEqual(buttonText, TeamDetailsViewConstants.unfollowButtonText)
        XCTAssertEqual(buttonIconString, TeamDetailsViewConstants.unfollowButtonIconString)
    }

    func test_button_assets_when_team_is_not_followed() async {
        let urlSessionMock = URLSessionMock()
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamDetailsViewModel(team: TeamDetails.mockLAL, networkManager: networkManager)

        await sut.setIsFollowed(isFollowed: false)
        let buttonText = await sut.buttonText
        let buttonIconString = await sut.buttonIconString

        XCTAssertEqual(buttonText, TeamDetailsViewConstants.followButtonText)
        XCTAssertEqual(buttonIconString, TeamDetailsViewConstants.followButtonIconString)
    }

    func test_ViewModel_Not_Nil_Calculated_Variables() async {
        let networkManager = NetworkManager(session: URLSessionMock())
        let sut = await TeamDetailsViewModel(team: TeamDetails.mockLAL, networkManager: networkManager)
        let backgroundColor = await sut.backgroundColor
        let expectedBackgroundColor = Color("LALColor")

        XCTAssertEqual(backgroundColor, expectedBackgroundColor)
    }
}
