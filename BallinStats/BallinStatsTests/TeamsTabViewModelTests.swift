//
//  TeamsTabViewModelTests.swift
//  BallinStatsTests
//
//  Created by Gerardo Leal on 05/10/23.
//

import XCTest
@testable import BallinStats

final class TeamsTabViewModelTests: XCTestCase {
    var data: Data?
    var error: Error?
    var response: URLResponse?
    var urlString: String = "https://www.balldontlie.io/api/v1/teams"

    func test_filtered_teams_property() async {
        let urlSessionMock = URLSessionMock()
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamsTabViewModel(networkManager: networkManager)
        let expectedResult = [TeamDetails.mockLAL]

        await sut.setTeams(teams: [TeamDetails.mockATL, TeamDetails.mockBOS, TeamDetails.mockLAL])
        await sut.setFilter(filter: .Pacific)
        let teams = await sut.filteredTeams

        XCTAssertEqual(teams, expectedResult)
    }

    func test_successful_fetch_teams() async {
        data = """
        {"data":[
            {"id":1,"abbreviation":"ATL","city":"Atlanta","conference":"East","division":"Southeast","full_name":"Atlanta Hawks","name":"Hawks"},
            {"id":2,"abbreviation":"BOS","city":"Boston","conference":"East","division":"Atlantic","full_name":"Boston Celtics","name":"Celtics"},
            {"id":14,"abbreviation":"LAL","city":"Los Angeles","conference":"West","division":"Pacific","full_name":"Los Angeles Lakers","name":"Lakers"}],
        "meta":{"total_pages":2,"current_page":1,"next_page":2,"per_page":30,"total_count":45}}
        """.data(using: .utf8)
        response = MockResponse.createResponse(urlString: urlString, statusCode: 200)
        let urlSessionMock = URLSessionMock(data: data, response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamsTabViewModel(networkManager: networkManager)
        let expectedResult = [TeamDetails.mockATL, TeamDetails.mockBOS, TeamDetails.mockLAL]

        await sut.fetchTeams(withPage: 1)
        let teams = await sut.teams

        XCTAssertEqual(teams, expectedResult)
    }

    func test_fetch_teams_not_found() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 404)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamsTabViewModel(networkManager: networkManager)

        await sut.fetchTeams(withPage: 1)
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.notFoundText)
    }

    func test_fetch_teams_bad_request() async {

        response = MockResponse.createResponse(urlString: urlString, statusCode: 400)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamsTabViewModel(networkManager: networkManager)

        await sut.fetchTeams(withPage: 1)
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.badRequestText)
    }

    func test_fetch_teams_server_error() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 429)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamsTabViewModel(networkManager: networkManager)

        await sut.fetchTeams(withPage: 1)
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.serverErrorText)
    }

    func test_fetch_teams_unknown_error() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 701)
        let urlSessionMock = URLSessionMock(response: response)
        let networkManager = NetworkManager(session: urlSessionMock)
        let sut = await TeamsTabViewModel(networkManager: networkManager)

        await sut.fetchTeams(withPage: 1)
        let hasError = await sut.hasError
        let errorMessage = await sut.errorMessage

        XCTAssertTrue(hasError)
        XCTAssertEqual(errorMessage, TextConstants.unknownErrorText)
    }
}
