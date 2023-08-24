//
//  PlayersTabViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import Foundation
import Combine
import SwiftUI

@MainActor class PlayersTabViewModel: ObservableObject {
    enum BrowsingState: Comparable {
        case good
        case isLoading
        case loadedAll
        case error(String)
    }

    @Published var searchText: String = ""
    @Published var players: [Player] = []
    @Published var state: BrowsingState = .good {
        didSet {
            print("state changed to: \(state)")
        }
    }

    var currentPage = 1
    var totalPages = 1
    var subscriptions = Set<AnyCancellable>()

    @ViewBuilder var loadingStateView: some View {
        switch self.state {
        case .good:
            Color.customBackgroundColor
                .onAppear {
                    self.loadMore()
                }
        case .isLoading:
            ProgressView()
        case .loadedAll:
            Text("No more results")
                .foregroundColor(.red)
        case .error(let message):
            Text(message)
                .foregroundColor(.red)
        }
    }

    init() {
        $searchText
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.players = []  // empty the players array when you change your searchTerm
                self?.totalPages = 1  // reestablish total pages to 1
                self?.currentPage = 1  // return to page 1 of results
                self?.state = .good  // reset state to good
                self?.fetchPlayers(for: term) // start a fetchPlayers when the searchterm changes
            }.store(in: &subscriptions)
    }
    
    func loadMore() {
        if self.currentPage <= self.totalPages {
            fetchPlayers(for: searchText)
        }
    }

    func fetchPlayers(for searchText: String) {

        // Only load when you are not already loading
        guard state == .good else {
            return
        }

        state = .isLoading

        NetworkManager.shared.fetchData(
            endpoint: EndpointBuilder.shared.getAllPlayersURL(page: currentPage, searchText: searchText),
            type: ResultsPage<Player>.self
        ) { result in
            if let result = result {
                self.players.append(contentsOf: result.data)
                self.totalPages = result.meta.totalPages
                self.state = (result.meta.totalPages == self.currentPage) ? .loadedAll : .good
                self.currentPage += 1
            }
        }
    }
}

extension PlayersTabViewModel {
    static let playersMock = [
        Player.mock
    ]
}
