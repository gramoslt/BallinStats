//
//  NetworkManagerTests.swift
//  BallinStatsTests
//
//  Created by Gerardo Leal on 04/10/23.
//

import XCTest
@testable import BallinStats

final class NetworkManagerTests: XCTestCase {
    var data: Data?
    var error: Error?
    var response: URLResponse?
    var urlString: String = "https://www.balldontlie.io/api/v1/season_averages?player_ids[]=237"

    func test_bad_url() async {
        let sut = NetworkManager(session: URLSessionMock())

        sut.fetchData(endpoint: URL(string: ""), type: ResultsPage<Player>.self) { result in
            switch result {
            case .success(_):
                XCTFail("shouldn't happen")
            case .failure(let error):
                XCTAssertEqual(error, ErrorHandler.NetworkError.badURL)
            }
        }
    }

    func test_bad_response() async {
        let sut = NetworkManager(session: URLSessionMock())

        sut.fetchData(endpoint: URL(string: urlString), type: ResultsPage<Player>.self) { result in
            switch result {
            case .success(_):
                XCTFail("shouldn't happen")
            case .failure(let error):
                XCTAssertEqual(error, ErrorHandler.NetworkError.badResponse)
            }
        }
    }

    func test_bad_data() async {
        response = MockResponse.createResponse(urlString: urlString, statusCode: 200)
        let sut = NetworkManager(session: URLSessionMock(response: response))

        sut.fetchData(endpoint: URL(string: urlString), type: ResultsPage<Player>.self) { result in
            switch result {
            case .success(_):
                XCTFail("shouldn't happen")
            case .failure(let error):
                XCTAssertEqual(error, ErrorHandler.NetworkError.noDataError)
            }
        }
    }

    func test_decoding_error() async {
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
        let sut = NetworkManager(session: URLSessionMock(data: data, response: response))

        sut.fetchData(endpoint: URL(string: urlString), type: ResultsPage<TeamDetails>.self) { result in
            switch result {
            case .success(_):
                XCTFail("shouldn't happen")
            case .failure(let error):
                XCTAssertEqual(error, ErrorHandler.NetworkError.decodingError)
            }
        }
    }
}
