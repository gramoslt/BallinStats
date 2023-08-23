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
    case AllTeams = "All Teams"
    case Atlantic
    case Central
    case Southeast
    case Northwest
    case Pacific
    case Southwest
}

@MainActor class TeamsTabViewModel: ObservableObject {
    @Published var teams: [TeamDetails] = []
    @Published var selectedFilter: Division = .AllTeams
    var filteredTeams: [TeamDetails] {
        if selectedFilter == .AllTeams {
            return teams
        } else {
            return self.teams.filter({$0.division == selectedFilter.rawValue})
        }
    }

    func fetchTeams(withPage page: Int) {
        NetworkManager.shared.fetchData(
            endpoint: EndpointBuilder.shared.getAllTeamsURL(page: page),
            type: ResultsPage<TeamDetails>.self
        ) { result in
            if let result = result {
                self.teams = result.data
            }
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
