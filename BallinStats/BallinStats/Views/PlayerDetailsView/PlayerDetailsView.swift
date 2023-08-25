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
                
                PlayerPositionText(playerDetailsViewModel: playerDetailsViewModel)
                
                VStack {
                    VStack {
                        HStack {
                            Text("Stats")
                                .bold()
                            Spacer()
                        }
                        .onAppear {
                            playerDetailsViewModel.fetchPlayerStats()
                        }

                        HStack (spacing: 0){
                            StatsGridCell(statTitle: "PPG", statValue: "\(playerDetailsViewModel.ppg)")
                            StatsGridCell(statTitle: "RPG", statValue: "\(playerDetailsViewModel.rpg)")
                            StatsGridCell(statTitle: "APG", statValue: "\(playerDetailsViewModel.apg)")
                        }
                    }
                    
                    PlayerMeasurementsTable(playerDetailsViewModel: playerDetailsViewModel)
                }
                .padding()
            }
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
