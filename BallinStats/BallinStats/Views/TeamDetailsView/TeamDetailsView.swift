//
//  TeamDetailsView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import SwiftUI

struct TeamDetailsView: View {
    @ObservedObject var teamDetailsViewModel: TeamDetailsViewModel
    
    init(teamDetailsViewModel: TeamDetailsViewModel) {
        self.teamDetailsViewModel = teamDetailsViewModel
        
        let foregroundUIColor = UIColor(teamDetailsViewModel.foregroundColor)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: foregroundUIColor]

       }

    var body: some View {
        NavigationStack {
            ScrollView {
                TeamAbbreviation(abbreviation: teamDetailsViewModel.team.abbreviation)

                TeamLogo(logoString: teamDetailsViewModel.team.logoString)

                TeamInfo(team: teamDetailsViewModel.team)
                
                FollowButton(teamDetailsViewModel: teamDetailsViewModel)

                GamesPlayedGrid(teamDetailsViewModel: teamDetailsViewModel)
            }
            .navigationTitle(teamDetailsViewModel.team.fullName)
            .background(teamDetailsViewModel.backgroundColor)
            .foregroundColor(teamDetailsViewModel.foregroundColor)
            .accentColor(teamDetailsViewModel.foregroundColor)
        }
    }
}

struct TeamDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsView(
            teamDetailsViewModel: TeamDetailsViewModel(team: TeamDetails.mockLAL)
        )
    }
}
