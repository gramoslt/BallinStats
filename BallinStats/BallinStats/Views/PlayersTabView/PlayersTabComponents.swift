//
//  PlayersTabComponents.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/08/23.
//

import Foundation
import SwiftUI

struct PlayersList: View {
    @ObservedObject var playersTabViewModel: PlayersTabViewModel

    var body: some View {
        List {
            Group {
                ForEach(playersTabViewModel.players) { player in
                    NavigationLink {
                        PlayerDetailsView(playerDetailsViewModel: PlayerDetailsViewModel(player: player))
                    } label: {
                        PlayerRow(player: player)
                    }
                }
                playersTabViewModel.loadingStateView
            }
            .listRowBackground(Color.customBackgroundColor)
            .listRowSeparatorTint(.customYellowStroke)
        }
        .listStyle(.plain)
        .background(.customBackgroundColor)
        .navigationBarTitle(TabViewConstants.playersLabel)
        .searchable(
            text: $playersTabViewModel.searchText,
            prompt: PlayersTabViewConstants.searchPrompt
        )
    }
}

struct PlayerRow: View {
    let player: Player

    var body: some View {
        HStack {
            Image(player.team.logoString)
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            
            VStack(alignment: .leading) {
                Text(player.fullName)
                    .font(.title3)
                    .bold()
                Text("Team: \(player.team.abbreviation)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            Spacer()
            Text(PlayersTabViewConstants.detailsText)
        }
    }
}
