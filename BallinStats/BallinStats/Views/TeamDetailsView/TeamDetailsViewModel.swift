//
//  TeamDetailsViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/08/23.
//

import Foundation
import SwiftUI

@MainActor class TeamDetailsViewModel: ObservableObject {
    @Published var games: [Game] = []
    var team: TeamDetails
    @Published var selectedYear: Int {
        didSet {
            games.removeAll()
            fetchFiveGames()
        }
    }
    @Published var isFollowed: Bool

    init(team: TeamDetails) {
        self.selectedYear = 2022
        self.team = team
        self.isFollowed = CoreDataManager.shared.checkIfItemExist(id: team.id)
    }

    func fetchFiveGames() {
        NetworkManager.shared.fetchData(
            endpoint: EndpointBuilder.shared.getGamesURL(season: selectedYear, teamId: team.id),
            type: ResultsPage<Game>.self
        ) { result in
            if let result = result {
                if result.data.count < 5{
                    self.games = result.data
                } else {
                    self.games = Array(result.data[0..<5])
                }
            }
        }
    }

    func unfollow() {
        CoreDataManager.shared.deleteTeamById(with: Int32(team.id))
        isFollowed.toggle()
    }
}

extension TeamDetailsViewModel {
    static let gamesMock = [Game.mockLALvsBOS, Game.mockLALvsATL]

    var backgroundColor: Color {
        Color("\(self.team.abbreviation)Color")
    }
}
