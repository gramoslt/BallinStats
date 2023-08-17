//
//  TeamsTabViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import Foundation

@MainActor class TeamsTabViewModel: ObservableObject {
//    @Published var teams: [TeamDetails] = []
    @Published var teams: [String] = []
    
    static let teamsMock = ["Lakers", "Celtics", "Hawks"]
}
