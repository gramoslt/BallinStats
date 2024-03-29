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
    static let mockLAL = TeamDetails(
        id: 14,
        abbreviation: "LAL",
        city: "Los Angeles",
        conference: "West",
        division: "Pacific",
        fullName: "Los Angeles Lakers",
        name: "Lakers"
    )
    static let mockBOS = TeamDetails(
        id: 2,
        abbreviation: "BOS",
        city: "Boston",
        conference: "East",
        division: "Atlantic",
        fullName: "Boston Celtics",
        name: "Celtics"
    )
    static let mockATL = TeamDetails(
        id: 1,
        abbreviation: "ATL",
        city: "Atlanta",
        conference: "East",
        division: "Southeast",
        fullName: "Atlanta Hawks",
        name: "Hawks"
    )
    
    init(team: Team){
        self.id = Int(team.id)
        self.abbreviation = team.abbreviation ?? ""
        self.city = team.city ?? ""
        self.conference = team.conference ?? ""
        self.division = team.division ?? ""
        self.fullName = team.fullName ?? ""
        self.name = team.name ?? ""
    }
}
