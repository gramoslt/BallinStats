//
//  TeamDetails.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import Foundation

struct TeamDetails: Codable, Identifiable, Equatable {
    let id: Int
    let abbreviation: String
    let city: String
    let conference: String
    let division: String
    let fullName: String
    let name: String

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
