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
    var heightFeet: String {
        "\(self.player.heightFeet)" ?? "N/A"
    }
    var weightPounds: String {
        "\(self.player.weightPounds)" ?? "N/A"
    }
    var heightInches: String {
        "\(self.player.heightInches)" ?? "N/A"
    }
}

extension PlayerDetailsViewModel {
    var backgroundColor: Color {
        Color("\(self.player.team.abbreviation)Color")
    }
}
