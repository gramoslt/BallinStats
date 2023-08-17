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
            ScrollView {
                List {
                    ForEach(playersTabViewModel.players) { player in
                        NavigationLink {
                            
                        } label: {
                            VStack {
                                HStack {
                                    Text(player.firstName + player.lastName)
                                }
                            }
                        }
                    }
                }
            }
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
