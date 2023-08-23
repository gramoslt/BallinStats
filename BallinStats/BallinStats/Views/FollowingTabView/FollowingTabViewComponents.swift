//
//  FollowingTabViewComponents.swift
//  BallinStats
//
//  Created by Gerardo Leal on 23/08/23.
//

import SwiftUI

struct TeamsList: View {
    @ObservedObject var followingTabViewModel: FollowingTabViewModel

    var body: some View {
        List {
            ForEach(followingTabViewModel.followedTeams) { team in
                NavigationLink {
                    TeamDetailsView(
                        teamDetailsViewModel: TeamDetailsViewModel(
                            team: team
                        )
                    )
                } label: {
                    TeamRow(team: team)
                }
            }
            .listRowBackground(Color.customBackgroundColor)
            .listRowSeparatorTint(.customYellowStroke)
        }
        .preferredColorScheme(.dark)
        .listStyle(.plain)
        .background(.customBackgroundColor)
        .navigationBarTitle(TabViewConstants.followingLabel)
    }
}

struct TeamRow: View {
    let team: TeamDetails

    var body: some View {
        HStack {
            Image(team.logoString)
                .resizable()
                .scaledToFit()
                .frame(height: ListRowConstants.logoHeight)
            
            VStack(alignment: .leading) {
                Text(team.fullName)
                    .font(.title3)
                    .bold()
                Text(team.abbreviation)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            Spacer()
            Text(PlayersTabViewConstants.detailsText)
        }
    }
}
