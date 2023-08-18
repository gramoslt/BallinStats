//
//  Game.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/08/23.
//

import Foundation

struct Game: Codable, Identifiable {
    let id: Int
    let homeTeam: TeamDetails
    let homeTeamScore: Int
    let visitorTeam: TeamDetails
    let visitorTeamScore: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case homeTeam = "home_team"
        case homeTeamScore = "home_team_score"
        case visitorTeam = "visitor_team"
        case visitorTeamScore = "visitor_team_score"
    }
}

extension Game {
    static let mock1 = Game(
        id: 100,
        homeTeam: TeamDetails.mockLAL,
        homeTeamScore: 100,
        visitorTeam: TeamDetails.mockBOS,
        visitorTeamScore: 98
    )

    static let mock2 = Game(
        id: 200,
        homeTeam: TeamDetails.mockLAL,
        homeTeamScore: 102,
        visitorTeam: TeamDetails.mockATL,
        visitorTeamScore: 113
    )
}
