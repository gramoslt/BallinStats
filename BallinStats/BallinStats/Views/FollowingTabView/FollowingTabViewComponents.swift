//
//  FollowingTabViewComponents.swift
//  BallinStats
//
//  Created by Gerardo Leal on 23/08/23.
//

import SwiftUI

struct TeamsList: View {
    @ObservedObject var followingTabViewModel: FollowingTabViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
      entity: Team.entity(),
      sortDescriptors: [NSSortDescriptor(keyPath: \Team.id, ascending: true)]
    ) var followedTeams: FetchedResults<Team>

    var body: some View {
        List {
            ForEach(followedTeams) { team in
                let tempTeam = TeamDetails(team: team)
                NavigationLink {
                    TeamDetailsView(
                        teamDetailsViewModel: TeamDetailsViewModel(team: tempTeam)
                    )
                } label: {
                    TeamRow(team: tempTeam)
                }
            }
            .onDelete(perform: unfollowTeam)
            .listRowBackground(Color.customBackgroundColor)
            .listRowSeparatorTint(.customYellowStroke)
        }
        .listStyle(.plain)
        .background(.customBackgroundColor)
        .navigationBarTitle(TabViewConstants.followingLabel)
    }

    func unfollowTeam(at offsets: IndexSet) {
            offsets.forEach { index in
                let team = self.followedTeams[index]
                self.managedObjectContext.delete(team)
              }
            CoreDataManager.shared.saveContext()
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
