//
//  PageMetaData.swift
//  BallinStats
//
//  Created by Gerardo Leal on 21/08/23.
//

import Foundation

struct PageMetaData: Decodable {
    let totalPages: Int
    let currentPage: Int
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case totalCount = "total_count"
    }
}
