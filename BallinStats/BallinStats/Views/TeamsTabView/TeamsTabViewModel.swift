//
//  TeamsTabViewModel.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import Foundation

enum Division: String, CaseIterable, Identifiable {
    var id: Self {
      return self
    }
    case AllTeams = "All Teams"
    case Atlantic
    case Central
    case Southeast
    case Northwest
    case Pacific
    case Southwest
}

@MainActor class TeamsTabViewModel: ObservableObject {
    @Published var teams: [TeamDetails] = []
    @Published var selectedFilter: Division = .AllTeams
    @Published var errorMessage: String? = ""
    @Published var hasError: Bool = false
    var networkManager: NetworkManager
    var filteredTeams: [TeamDetails] {
        if selectedFilter == .AllTeams {
            return teams
        } else {
            return self.teams.filter({$0.division == selectedFilter.rawValue})
        }
    }

    init(networkManager: NetworkManager = LiveNetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchTeams(withPage page: Int) {
        networkManager.fetchData(
            endpoint: EndpointBuilder.shared.getAllTeamsURL(page: page),
            type: ResultsPage<TeamDetails>.self
        ) { [weak self] result in
            self?.handleResult(result: result)
        }
    }

    private func handleResult(result: Result<ResultsPage<TeamDetails>, ErrorHandler.NetworkError>) {
        switch result {
        case .success(let result):
            self.teams = result.data
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

extension TeamsTabViewModel {
    static let teamsMock = [
        TeamDetails.mockLAL,
        TeamDetails.mockBOS,
        TeamDetails.mockATL
    ]
}
