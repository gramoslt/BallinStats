//
//  TeamDetailsLandscapeView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 30/08/23.
//

import SwiftUI

struct TeamDetailsLandscapeView: View {
    @ObservedObject var teamDetailsViewModel: TeamDetailsViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                teamDetailsViewModel.backgroundColor
                    .ignoresSafeArea()

                ScrollView {
                    HStack {
                        TeamLogo(logoString: teamDetailsViewModel.team.logoString)

                        VStack {
                            TeamAbbreviation(abbreviation: teamDetailsViewModel.team.abbreviation)
                            TeamInfo(team: teamDetailsViewModel.team)

                            FollowButton(
                                text: teamDetailsViewModel.buttonText,
                                iconString: teamDetailsViewModel.buttonIconString
                            ) {
                                teamDetailsViewModel.buttonAction()
                            }

                            GamesPlayedGrid(teamDetailsViewModel: teamDetailsViewModel)
                        }
                    }
                    .ignoresSafeArea()
                    .navigationTitle(teamDetailsViewModel.team.fullName)
                }
            }
        }
    }
}

struct TeamDetailsLandscapeView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsLandscapeView(teamDetailsViewModel: TeamDetailsViewModel(team: TeamDetails.mockLAL))
    }
}
