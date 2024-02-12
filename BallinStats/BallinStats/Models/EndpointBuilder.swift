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
    }

    func getAllTeamsURL(page: Int) -> URL? {
        components.path = Self.teamsPath
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return components.url
    }

    func getAllPlayersURL(page: Int, searchText: String?) -> URL? {
        components.path = Self.playersPath
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        if let search = searchText {
            components.queryItems?.append(URLQueryItem(name: "search", value: search))
        }
        return components.url
    }

    func getGamesURL(season: Int, teamId: Int) -> URL? {
        components.path = Self.gamesPath
        components.queryItems = [
            URLQueryItem(name: "seasons[]", value: "\(season)"),
            URLQueryItem(name: "team_ids[]", value: "\(teamId)")
        ]
        return components.url
    }

    func getPlayerSeasonAveragesURL(season: Int?, playerId: Int) -> URL? {
        components.path = Self.playerSeasonAveragesPath
        if let season = season {
            components.queryItems = [
                URLQueryItem(name: "season", value: "\(season)")
            ]
        }
        components.queryItems?.append(URLQueryItem(name: "player_ids[]", value: "\(playerId)"))

        return components.url
    }
}

extension EndpointBuilder {
    static let teamsPath: String = "/api/v1/teams"
    static let playersPath: String = "/api/v1/players"
    static let gamesPath: String = "/api/v1/games"
    static let playerSeasonAveragesPath: String = "/api/v1/season_averages"
}
