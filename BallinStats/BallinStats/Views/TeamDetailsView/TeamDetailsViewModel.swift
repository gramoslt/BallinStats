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
    var networkManager: NetworkManager
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
    @Published var errorMessage: String? = ""
    @Published var hasError: Bool = false

    init(team: TeamDetails, networkManager: NetworkManager = NetworkManager(session: URLSession.shared)) {
        self.selectedYear = 2022
        self.team = team
        self.isFollowed = CoreDataManager.shared.checkIfItemExist(id: team.id)
        self.networkManager = networkManager
    }

    func setYear(year: Int) {
        self.selectedYear = year
    }

    func setIsFollowed(isFollowed: Bool) {
        self.isFollowed = isFollowed
    }

    func fetchFiveGames() {
        networkManager.fetchData(
            endpoint: EndpointBuilder.shared.getGamesURL(season: selectedYear, teamId: team.id),
            type: ResultsPage<Game>.self
        ) { [weak self] result in
            self?.handleResult(result: result)
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

    private func handleResult(result: Result<ResultsPage<Game>, ErrorHandler.NetworkError>) {
        switch result {
        case .success(let result):
            if result.data.count < 5{
                self.games = result.data
            } else {
                self.games = Array(result.data[0..<5])
            }

        case .failure(let error):
            self.handle(error: error)
        }
    }

    private func handle(error: ErrorHandler.NetworkError) {
        switch error {
        case .notFound:
            errorMessage = TextConstants.notFoundText
        case .badRequest:
            errorMessage = TextConstants.badRequestText
        case .serverError:
            errorMessage = TextConstants.serverErrorText
        default:
            errorMessage = TextConstants.unknownErrorText
        }
        hasError = true
    }
}

extension TeamDetailsViewModel {
    static let gamesMock = [Game.mockLALvsBOS, Game.mockLALvsATL]

    var backgroundColor: Color {
        Color("\(self.team.abbreviation)Color")
    }
}
