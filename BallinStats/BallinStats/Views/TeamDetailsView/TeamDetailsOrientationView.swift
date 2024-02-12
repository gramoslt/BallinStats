//
//  TeamDetailsOrientationView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 30/08/23.
//

import SwiftUI

struct TeamDetailsOrientationView: View {
    @ObservedObject var teamDetailsViewModel: TeamDetailsViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass!

    var body: some View {
        if verticalSizeClass == .compact {
            TeamDetailsLandscapeView(teamDetailsViewModel: teamDetailsViewModel)
        } else {
            TeamDetailsView(teamDetailsViewModel: teamDetailsViewModel)
        }
    }
}

struct TeamDetailsOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsOrientationView(teamDetailsViewModel: TeamDetailsViewModel(team: TeamDetails.mockLAL))
    }
}
