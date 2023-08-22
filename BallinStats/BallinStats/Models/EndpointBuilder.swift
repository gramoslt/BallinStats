//
//  EndpointBuilder.swift
//  BallinStats
//
//  Created by Gerardo Leal on 21/08/23.
//

import Foundation

class EndpointBuilder {
    private var components: URLComponents

    static let shared: EndpointBuilder = EndpointBuilder()

    private init() {
        self.components = URLComponents()
        self.components.scheme = "https"
        self.components.host = "www.balldontlie.io"
        self.components.path = "/api/v1"
    }

    func getAllTeamsURL(page: Int) -> URL? {
        components.path += Self.teamsPath
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return components.url
    }

    func getAllPlayersURL(page: Int, searchText: String?) -> URL? {
        components.path += Self.playersPath
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        if let search = searchText {
            components.queryItems?.append(URLQueryItem(name: "search", value: search))
        }
        return components.url
    }
}

extension EndpointBuilder {
    static let teamsPath: String = "/teams"
    static let playersPath: String = "/players"
}
