//
//  PlayerDetailsLandscapeView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 31/08/23.
//

import SwiftUI

struct PlayerDetailsLandscapeView: View {
    @ObservedObject var playerDetailsViewModel: PlayerDetailsViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    VStack {
                        TeamLogo(logoString: playerDetailsViewModel.player.team.logoString)
                    }
                    VStack {
                        PlayerPosition(playerDetailsViewModel: playerDetailsViewModel)
                        PlayerStatsTable(playerDetailsViewModel: playerDetailsViewModel)
                        PlayerMeasurementsTable(playerDetailsViewModel: playerDetailsViewModel)
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .background(playerDetailsViewModel.backgroundColor)
            .navigationTitle(playerDetailsViewModel.player.fullName)
        }
    }
}

struct PlayerDetailsLandscapeView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsLandscapeView(playerDetailsViewModel: PlayerDetailsViewModel(player: Player.mock))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
