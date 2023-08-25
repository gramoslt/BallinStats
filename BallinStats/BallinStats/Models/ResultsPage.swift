//
//  ResultsPage.swift
//  BallinStats
//
//  Created by Gerardo Leal on 21/08/23.
//

import Foundation

struct ResultsPage<T:Codable>: Codable {
    let data: [T]
    let meta: PageMetaData?
}
