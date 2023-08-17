//
//  TeamsTabViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import Foundation

enum Division: String, CaseIterable, Identifiable {
    var id: Self {
      return self
    }
    case Atlantic
    case Central
    case SouthEast
    case NorthWest
    case Pacific
    case SouthWest
    case AllTeams = "All Teams"
}

@MainActor class TeamsTabViewModel: ObservableObject {
//    @Published var teams: [TeamDetails] = []
    @Published var teams: [String] = []
    @Published var selectedFilter: Division = .AllTeams

    static let teamsMock = ["Lakers", "Celtics", "Hawks"]
}
