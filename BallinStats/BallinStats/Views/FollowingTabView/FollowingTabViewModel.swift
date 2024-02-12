//
//  FollowingTabViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 23/08/23.
//

import Foundation

@MainActor class FollowingTabViewModel: ObservableObject {
    @Published var followedTeams: [TeamDetails] = followedTeamsMock
}

extension FollowingTabViewModel {
    static let followedTeamsMock = [TeamDetails.mockLAL, TeamDetails.mockBOS, TeamDetails.mockATL]
}
