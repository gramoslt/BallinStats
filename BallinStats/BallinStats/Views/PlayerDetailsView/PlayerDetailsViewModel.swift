//
//  PlayerDetailsViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 23/08/23.
//

import Foundation
import SwiftUI

@MainActor class PlayerDetailsViewModel: ObservableObject {
    var player: Player
    var networkManager: NetworkManager

    init(player: Player, networkManager: NetworkManager = NetworkManager(session: .shared)) {
        self.player = player
        self.networkManager = networkManager
    }
    @Published var ppg: Float = 0
    @Published var rpg: Float = 0
    @Published var apg: Float = 0
    var heightFeet: String {
        if let height = self.player.heightFeet {
            return "\(height)"
        }
        return PlayerDetailsViewConstants.notAvailableString
    }
    var weightPounds: String {
        if let weight = self.player.weightPounds {
            return "\(weight)"
        }
        return PlayerDetailsViewConstants.notAvailableString
    }
    var heightInches: String {
        if let height = self.player.heightInches {
            return "\(height)"
        }
        return PlayerDetailsViewConstants.notAvailableString
    }
    @Published var errorMessage: String? = ""
    @Published var hasError: Bool = false

    func fetchPlayerStats() {
        networkManager.fetchData(
            endpoint: EndpointBuilder.shared.getPlayerSeasonAveragesURL(season: nil, playerId: player.id),
            type: ResultsPage<PlayerStats>.self
        ) { [weak self] result in
            self?.handleResult(result: result)
        }
    }

    private func handleResult(result: Result<ResultsPage<PlayerStats>, ErrorHandler.NetworkError>) {
        switch result {
        case .success(let result):
            if !result.data.isEmpty {
                self.ppg = result.data[0].pts
                self.rpg = result.data[0].reb
                self.apg = result.data[0].ast
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

extension PlayerDetailsViewModel {
    var backgroundColor: Color {
        Color("\(self.player.team.abbreviation)Color")
    }
}
