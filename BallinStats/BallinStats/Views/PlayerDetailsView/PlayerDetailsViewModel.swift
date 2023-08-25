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
}

extension PlayerDetailsViewModel {
    var backgroundColor: Color {
        Color("\(self.player.team.abbreviation)Color")
    }
}
