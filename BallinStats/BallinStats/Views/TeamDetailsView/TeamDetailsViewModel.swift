//
//  TeamDetailsViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/08/23.
//

import Foundation

enum Season: String, CaseIterable, Identifiable {
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

@MainActor class TeamDetailsViewModel: ObservableObject {
    @Published var games: [String] = []
}
