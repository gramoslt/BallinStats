//
//  TabNavigationView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import SwiftUI

struct TabNavigationView: View {
    var body: some View {
        TabView {
            TeamsTabView()
                .tabItem {
                    Label("Teams", systemImage: "basketball.fill")
                }

            PlayersTabView()
                .tabItem {
                    Label("Players", systemImage: "figure.basketball")
                }

            FollowingTabView()
                .tabItem {
                    Label("Following", systemImage: "star.fill")
                }
        }
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
    }
}
