//
//  PlayersTabViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import Foundation
import Combine

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
    @Published var errorMessage: String? = ""
    @Published var hasError: Bool = false
    var networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager(session: URLSession.shared)) {
        self.networkManager = networkManager

        $searchText
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                guard let strongSelf = self else { return }
                strongSelf.players = []  // empty the players array when you change your searchTerm
                strongSelf.totalPages = 1  // reestablish total pages to 1
                strongSelf.currentPage = 1  // return to page 1 of results
                strongSelf.state = .good  // reset state to good
                strongSelf.fetchPlayers(for: term) // start a fetchPlayers when the searchterm changes
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

        networkManager.fetchData(
            endpoint: EndpointBuilder.shared.getAllPlayersURL(page: currentPage, searchText: searchText),
            type: ResultsPage<Player>.self
        ) { [weak self] result in
            self?.handleResult(result: result)
        }
    }

    private func handleResult(result: Result<ResultsPage<Player>, ErrorHandler.NetworkError>) {
        switch result {
        case .success(let result):
            self.players.append(contentsOf: result.data)
            self.totalPages = result.meta?.totalPages ?? 1
            self.state = (result.meta?.totalPages == self.currentPage) ? .loadedAll : .good
            self.currentPage += 1

        case .failure(let error):
            self.handle(error: error)
        }
    }

    private func handle(error: ErrorHandler.NetworkError) {
        switch error {
        case .notFound:
            errorMessage = TextConstants.notFoundText
        case .badRequest:
            errorMessage = TextConstants.badRequestText
        case .serverError:
            errorMessage = TextConstants.serverErrorText
        default:
            errorMessage = TextConstants.unknownErrorText
        }
        hasError = true
    }
}

extension PlayersTabViewModel {
    static let playersMock = [
        Player.mockLebron
    ]
}
