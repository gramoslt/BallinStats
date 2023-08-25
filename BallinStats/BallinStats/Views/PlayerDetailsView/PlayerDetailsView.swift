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

                        HStack (spacing: 0){
                            StatsGridCell(statTitle: "PPG", statValue: "\(28)")
                            StatsGridCell(statTitle: "RPG", statValue: "\(8.3)")
                            StatsGridCell(statTitle: "APG", statValue: "\(4.2)")
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
