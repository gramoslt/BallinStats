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
    public static let followButtonIconString = "plus"
}

enum PlayersTabViewConstants {
    public static let searchPrompt = "Search Player"
    public static let detailsText = "Details"
}

enum ListRowConstants {
    public static let logoHeight = CGFloat(40)
}
