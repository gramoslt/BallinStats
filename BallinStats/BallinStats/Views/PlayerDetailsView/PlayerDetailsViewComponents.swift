//
//  PlayerDetailsViewComponents.swift
//  BallinStats
//
//  Created by Gerardo Leal on 23/08/23.
//

import Foundation
import SwiftUI

struct PlayerPositionText: View {
    @ObservedObject var playerDetailsViewModel: PlayerDetailsViewModel

    var body: some View {
        HStack {
            Text(playerDetailsViewModel.player.position)
                .font(.title2)
                .bold()
            Spacer()
        }
        .padding()
    }
}

struct PlayerStatsTable: View {
    @ObservedObject var playerDetailsViewModel: PlayerDetailsViewModel

    var body: some View {
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
    }
}

struct PlayerMeasurementsTable: View {
    @ObservedObject var playerDetailsViewModel: PlayerDetailsViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Measurements")
                    .bold()
                Spacer()
            }
            
            HStack (spacing: 0){
                StatsGridCell(statTitle: "Height (feet)", statValue: playerDetailsViewModel.heightFeet)
                StatsGridCell(statTitle: "Height (in)", statValue: playerDetailsViewModel.heightInches)
                StatsGridCell(statTitle: "Weight", statValue: playerDetailsViewModel.weightPounds)
            }
        }
    }
}

struct StatsGridCell: View {
    var statTitle: String
    var statValue: String

    var body: some View {
        VStack{
            Text(statTitle)
            Text(statValue)
                .font(.title)
                .bold()
        }
        .padding()
        .frame(maxWidth: PlayerDetailsViewConstants.statsGridCellWidth, maxHeight: PlayerDetailsViewConstants.statsGridCellHeight)
        .border(Color.accentColor)
    }
}

