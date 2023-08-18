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
            ForEach(playersTabViewModel.players) { player in
                NavigationLink {
                    PlayerDetailsView(player: player)
                } label: {
                    PlayerRow(player: player)
                }
            }
            .listRowBackground(Color.customBackgroundColor)
            .listRowSeparatorTint(.customYellowStroke)
        }
        .preferredColorScheme(.dark)
        .listStyle(.plain)
        .background(.customBackgroundColor)
        .navigationBarTitle(TabViewConstants.playersLabel)
        .searchable(
            text: $playersTabViewModel.searchText,
            prompt: "Search Player"
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
                    .fontDesign(.rounded)
                Text("Team: \(player.team.abbreviation)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
            }
            Spacer()
            Text("Details")
                .fontDesign(.rounded)
        }
    }
}
