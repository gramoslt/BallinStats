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
    case Southeast
    case Northwest
    case Pacific
    case Southwest
    case AllTeams = "All Teams"
}

@MainActor class TeamsTabViewModel: ObservableObject {
    @Published var teams: [TeamDetails] = teamsMock
    @Published var selectedFilter: Division = .AllTeams
    var filteredTeams: [TeamDetails] {
        if selectedFilter == .AllTeams {
            return teams
        } else {
            return self.teams.filter({$0.division == selectedFilter.rawValue})
        }
    }
}

extension TeamsTabViewModel {
    static let teamsMock = [
        TeamDetails.mockLAL,
        TeamDetails.mockBOS,
        TeamDetails.mockATL
    ]
}
