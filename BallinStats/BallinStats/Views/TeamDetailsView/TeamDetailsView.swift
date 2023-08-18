//
//  TeamDetailsView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import SwiftUI

struct TeamDetailsView: View {
    var team: TeamDetails
    @StateObject var teamDetailsViewModel = TeamDetailsViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                TeamAbbreviation(abbreviation: team.abbreviation)

                TeamLogo(logoString: team.logoString)

                TeamInfo(team: team)

                GamesPlayedGrid(teamDetailsViewModel: teamDetailsViewModel)
            }
            .navigationTitle(team.fullName)
            .background(.customBackgroundColor)
        }
        .preferredColorScheme(.dark)
    }
}

struct TeamDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsView(team: TeamDetails.mockLAL)
    }
}
