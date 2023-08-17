//
//  TabNavigationView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import SwiftUI

struct TabNavigationView: View {
    @StateObject var teamsTabViewModel = TeamsTabViewModel()

    var body: some View {
        TabView {
            TeamsTabView(teamsTabViewModel: teamsTabViewModel)
                .tabItem {
                    Label(TabViewConstants.teamsLabel,
                          systemImage: TabViewConstants.teamsIconString
                    )
                }

            PlayersTabView()
                .tabItem {
                    Label(TabViewConstants.playersLabel,
                          systemImage: TabViewConstants.playersIconString
                    )
                }

            FollowingTabView()
                .tabItem {
                    Label(TabViewConstants.followingLabel,
                          systemImage: TabViewConstants.followingIconString
                    )
                }
        }
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
    }
}
