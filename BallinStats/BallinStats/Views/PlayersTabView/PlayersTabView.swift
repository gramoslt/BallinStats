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
