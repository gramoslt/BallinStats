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

    init(player: Player) {
        self.player = player
    }
    @Published var ppg: Float = 0
    @Published var rpg: Float = 0
    @Published var apg: Float = 0
    var heightFeet: String {
        if let height = self.player.heightFeet {
            return "\(height)"
        }
        return "N/A"
    }
    var weightPounds: String {
        if let weight = self.player.weightPounds {
            return "\(weight)"
        }
        return "N/A"
    }
    var heightInches: String {
        if let height = self.player.heightInches {
            return "\(height)"
        }
        return "N/A"
    }

    func fetchPlayerStats() {
        NetworkManager.shared.fetchData(
            endpoint: EndpointBuilder.shared.getPlayerSeasonAveragesURL(season: nil, playerId: player.id),
            type: ResultsPage<PlayerStats>.self
        ) { result in
            if let result = result {
                if !result.data.isEmpty {
                    self.ppg = result.data[0].pts
                    self.rpg = result.data[0].reb
                    self.apg = result.data[0].ast
                }
            }
        }
    }
}

extension PlayerDetailsViewModel {
    var backgroundColor: Color {
        Color("\(self.player.team.abbreviation)Color")
    }
}
