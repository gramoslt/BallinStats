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
        .frame(maxWidth: PlayerDetailsViewConstants.statsGridCellWidth)
        .border(.white)
    }
}
