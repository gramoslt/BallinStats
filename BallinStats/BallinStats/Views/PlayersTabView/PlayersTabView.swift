//
//  PlayersTabView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import SwiftUI

struct PlayersTabView: View {
    @ObservedObject var playersTabViewModel: PlayersTabViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(playersTabViewModel.players) { player in
                    NavigationLink {
                        PlayerDetailsView(player: player)
                    } label: {
                        HStack {
                            Image(player.team.logoString)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                            VStack(alignment: .leading) {
                                Text(player.fullName)
                                Text("Team: \(player.team.abbreviation)")
                            }
                            Spacer()
                            Text("Details")
                        }
                    }
                }
            }
            .listStyle(.plain)
            //            .background(Color(ColorString.backgroundColor))
            .navigationBarTitle(TabViewConstants.playersLabel)
            .searchable(
                text: $playersTabViewModel.searchText,
                prompt: "Search Player"
            )
        }
    }
}

struct PlayersTabView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersTabView(playersTabViewModel: PlayersTabViewModel())
    }
}
