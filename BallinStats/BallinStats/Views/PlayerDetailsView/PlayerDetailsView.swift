//
//  PlayerDetailsView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import SwiftUI

struct PlayerDetailsView: View {
    @ObservedObject var playerDetailsViewModel: PlayerDetailsViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                TeamLogo(logoString: playerDetailsViewModel.player.team.logoString)
                
                PlayerPosition(playerDetailsViewModel: playerDetailsViewModel)
                
                VStack {
                    PlayerStatsTable(playerDetailsViewModel: playerDetailsViewModel)
                    
                    PlayerMeasurementsTable(playerDetailsViewModel: playerDetailsViewModel)
                }
                .padding()
            }
            .foregroundColor(playerDetailsViewModel.foregroundColor)
            .accentColor(playerDetailsViewModel.foregroundColor)
            .frame(maxWidth: .infinity)
            .background(playerDetailsViewModel.backgroundColor)
            .navigationTitle(playerDetailsViewModel.player.fullName)
        }
    }
}

struct PlayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsView(playerDetailsViewModel: PlayerDetailsViewModel(player: Player.mock))
    }
}
