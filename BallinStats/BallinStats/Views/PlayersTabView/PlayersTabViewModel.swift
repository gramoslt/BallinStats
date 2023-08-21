//
//  PlayersTabViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import Foundation

@MainActor class PlayersTabViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var players: [Player] = playersMock
}

extension PlayersTabViewModel {
    static let playersMock = [
        Player.mock
    ]
}
