//
//  Constants.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import Foundation

enum TabViewConstants {
    public static let teamsLabel = "Teams"
    public static let playersLabel = "Players"
    public static let followingLabel = "Following"
    public static let teamsIconString = "basketball.fill"
    public static let playersIconString = "figure.basketball"
    public static let followingIconString = "heart.fill"
}

enum TeamsTabViewConstants {
    public static let logoWidth = CGFloat(160)
    public static let logoHeight = CGFloat(140)
    public static let columnMinimum = CGFloat(150)
    public static let cornerRadius = CGFloat(10)
    public static let padding = CGFloat(10)
}

enum TeamDetailsViewConstants {
    public static let logoWidth = CGFloat(360)
    public static let columnMinimum = CGFloat(300)
    public static let lastGamesPlayedText = "Last Games Played:"
    public static let gridLogoHeight = CGFloat(20)
    public static let followButtonWidth = CGFloat(350)
    public static let followButtonHeight = CGFloat(50)
    public static let followButtonText = "Follow"
    public static let unfollowButtonText = "Unfollow"
    public static let followButtonIconString = "heart"
    public static let unfollowButtonIconString = "heart.slash"
}

enum PlayersTabViewConstants {
    public static let searchPrompt = "Search Player"
    public static let detailsText = "Details"
}

enum PlayerDetailsViewConstants {
    public static let statsGridCellWidth = CGFloat(120)
    public static let statsGridCellHeight = CGFloat(80)
    public static let notAvailableString = "N/A"
}

enum ListRowConstants {
    public static let logoHeight = CGFloat(40)
    public static let logoWidth = CGFloat(70)
}

enum NetworkMonitorConstants {
    public static let networkMonitor = "NetworkMonitor"
    public static let networkMonitorMock = "MockNetworkMonitor"
    public static let networkMonitorStatus = "NetworkMonitor status:"
}

enum NoNetworkViewConstants {
    public static let noNetworkIcon = "wifi.slash"
    public static let noNetworkText = "No network available"
    public static let oopsText = "Oops!"
    public static let imageWidth = CGFloat(110)
    public static let imageHeight = CGFloat(100)
}

enum TextConstants {
    public static let notFoundText =  "Resource not found."
    public static let badRequestText =  "Bad request."
    public static let serverErrorText =  "Server Error."
    public static let unknownErrorText =  "An unknown error occurred."
}
