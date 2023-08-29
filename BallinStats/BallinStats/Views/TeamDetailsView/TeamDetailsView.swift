//
//  TeamDetailsView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import SwiftUI

struct TeamDetailsView: View {
    @ObservedObject var teamDetailsViewModel: TeamDetailsViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor

    var body: some View {
        NavigationStack {
            ScrollView {
                TeamAbbreviation(abbreviation: teamDetailsViewModel.team.abbreviation)

                TeamLogo(logoString: teamDetailsViewModel.team.logoString)

                TeamInfo(team: teamDetailsViewModel.team)
                
                FollowButton(teamDetailsViewModel: teamDetailsViewModel)

                if networkMonitor.isConnected {
                    GamesPlayedGrid(teamDetailsViewModel: teamDetailsViewModel)
                } else {
                    NoNetworkView()
                }
            }
            .navigationTitle(teamDetailsViewModel.team.fullName)
            .background(teamDetailsViewModel.backgroundColor)
        }
    }
}

struct TeamDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsView(
            teamDetailsViewModel: TeamDetailsViewModel(team: TeamDetails.mockLAL)
        )
        .environmentObject(NetworkMonitor.init(isConnected: false))
    }
}
