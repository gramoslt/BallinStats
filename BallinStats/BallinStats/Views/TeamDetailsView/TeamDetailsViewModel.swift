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
    var buttonText: String {
        isFollowed ? TeamDetailsViewConstants.unfollowButtonText : TeamDetailsViewConstants.followButtonText
    }
    var buttonIconString: String {
        isFollowed ? TeamDetailsViewConstants.unfollowButtonIconString : TeamDetailsViewConstants.followButtonIconString
    }
    var buttonAction: () -> Void {
        isFollowed ? unfollow : follow
    }

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
    func follow() {
        CoreDataManager.shared.saveTeam(team: team)
        isFollowed = true
    }

    func unfollow() {
        CoreDataManager.shared.deleteTeamById(with: Int32(team.id))
        isFollowed = false
    }
}

extension TeamDetailsViewModel {
    static let gamesMock = [Game.mockLALvsBOS, Game.mockLALvsATL]

    var backgroundColor: Color {
        Color("\(self.team.abbreviation)Color")
    }
}
