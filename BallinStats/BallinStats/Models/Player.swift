//
//  Player.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import Foundation

struct Player: Codable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    let position: String
    let heightFeet: Int
    let heightInches: Int
    let weightPounds: Int
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
    static let mock = Player(
        id: 237,
        firstName: "LeBron",
        lastName: "James",
        position: "F",
        heightFeet: 6,
        heightInches: 8,
        weightPounds: 250,
        team: TeamDetails.mockLAL
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
