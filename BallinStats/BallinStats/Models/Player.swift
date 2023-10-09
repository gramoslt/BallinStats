//
//  Player.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import Foundation

struct Player: Codable, Identifiable, Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id && lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.position == rhs.position && lhs.heightFeet == rhs.heightFeet &&
        lhs.heightInches == rhs.heightInches && lhs.weightPounds == rhs.weightPounds && lhs.team == rhs.team
    }

    let id: Int
    let firstName: String
    let lastName: String
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    let position: String
    let heightFeet: Float?
    let heightInches: Float?
    let weightPounds: Float?
    let team: TeamDetails

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case position
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case weightPounds = "weight_pounds"
        case team
    }
}

extension Player {
    static let mockLebron = Player(
        id: 237,
        firstName: "LeBron",
        lastName: "James",
        position: "F",
        heightFeet: 6,
        heightInches: 8,
        weightPounds: 250,
        team: TeamDetails.mockLAL
    )

    static let mockTatum = Player(
        id: 434,
        firstName: "Jayson",
        lastName: "Tatum",
        position: "F",
        heightFeet: 6,
        heightInches: 8,
        weightPounds: 208,
        team: TeamDetails.mockBOS
    )
}

struct PlayerStats: Codable, Identifiable{
    let id: Int
    let pts: Float
    let reb: Float
    let ast: Float

    enum CodingKeys: String, CodingKey {
        case id = "player_id"
        case pts
        case reb
        case ast
    }
}

extension PlayerStats {
    static let mock = PlayerStats(
        id: 237,
        pts: 26.97,
        reb: 8.54,
        ast: 7.38
    )
}
