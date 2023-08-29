//
//  TabNavigationView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import SwiftUI

struct TabNavigationView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @StateObject var playersTabViewModel: PlayersTabViewModel = PlayersTabViewModel()
    @StateObject var teamsTabViewModel = TeamsTabViewModel()
    @StateObject var followingTabViewModel = FollowingTabViewModel()

    var body: some View {
            TabView {
                if networkMonitor.isConnected {
                    TeamsTabView(teamsTabViewModel: teamsTabViewModel)
                        .tabItem {
                            Label(TabViewConstants.teamsLabel,
                                  systemImage: TabViewConstants.teamsIconString
                            )
                        }

                    PlayersTabView(playersTabViewModel: playersTabViewModel)
                        .tabItem {
                            Label(TabViewConstants.playersLabel,
                                  systemImage: TabViewConstants.playersIconString
                            )
                        }

                } else {
                    NoNetworkView()
                        .tabItem {
                            Label(TabViewConstants.teamsLabel,
                                  systemImage: TabViewConstants.teamsIconString
                            )
                        }

                    NoNetworkView()
                        .tabItem {
                            Label(TabViewConstants.playersLabel,
                                  systemImage: TabViewConstants.playersIconString
                            )
                        }
                }

                FollowingTabView(followingTabViewModel: followingTabViewModel)
                    .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
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
            .environmentObject(NetworkMonitor.init(isConnected: false))
        TabNavigationView()
            .preferredColorScheme(.dark)
            .environmentObject(NetworkMonitor.init(isConnected: true))
    }
}
