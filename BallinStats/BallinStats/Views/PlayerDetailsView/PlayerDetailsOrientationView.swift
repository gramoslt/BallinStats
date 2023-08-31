//
//  PlayerDetailsOrientationView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 31/08/23.
//

import SwiftUI

struct PlayerDetailsOrientationView: View {
    @ObservedObject var playerDetailsViewModel: PlayerDetailsViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass!

    var body: some View {
        if verticalSizeClass == .compact {
            PlayerDetailsLandscapeView(playerDetailsViewModel: playerDetailsViewModel)
        } else {
            PlayerDetailsView(playerDetailsViewModel: playerDetailsViewModel)
        }
    }
}

struct PlayerDetailsOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsOrientationView(playerDetailsViewModel: PlayerDetailsViewModel(player: Player.mock))
    }
}
