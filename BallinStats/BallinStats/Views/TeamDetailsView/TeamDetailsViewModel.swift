//
//  TeamDetailsViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/08/23.
//

import Foundation

enum Season: Int, CaseIterable, Identifiable {
    var id: Self {
      return self
    }
    case AllTeams
    case Atlantic
    case Central
    case Southeast
    case Northwest
    case Pacific
    case Southwest
}

@MainActor class TeamDetailsViewModel: ObservableObject {
    @Published var games: [Game] = gamesMock
}

extension TeamDetailsViewModel {
    static let gamesMock = [Game.mock1, Game.mock2]
}
