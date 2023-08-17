//
//  TeamDetails.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import Foundation

struct TeamDetails: Codable, Identifiable {
    let id: Int
    let abbreviation: String
    let city: String
    let conference: String
    let division: String
    let fullName: String
    let name: String
    var logoString: String {
        self.name + "-logo"
    }

    enum CodingKeys: String, CodingKey {
        case id,
             abbreviation,
             city,
             conference,
             division,
             fullName = "full_name",
             name
    }
}

extension TeamDetails {
    static let mock = TeamDetails(
        id: 14,
        abbreviation: "LAL",
        city: "Los Angeles",
        conference: "West",
        division: "Pacific",
        fullName: "Los Angeles Lakers",
        name: "Lakers"
    )
}
