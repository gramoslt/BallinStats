//
//  TeamDetailsViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/08/23.
//

import Foundation


@MainActor class TeamDetailsViewModel: ObservableObject {
    @Published var games: [Game] = gamesMock
    @Published var selectedYear: Int = 2022 {
        didSet {
            print("Games from \(selectedYear) Season")
        }
    }
}

extension TeamDetailsViewModel {
    static let gamesMock = [Game.mockLALvsBOS, Game.mockLALvsATL]
}
