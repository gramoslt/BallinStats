//
//  TeamDetailsViewComponents.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/08/23.
//

import Foundation
import SwiftUI

struct GamesPlayedGrid: View {
    @ObservedObject var teamDetailsViewModel: TeamDetailsViewModel
    let columns = [
        GridItem(.adaptive(minimum: TeamDetailsViewConstants.columnMinimum))
    ]

    var body: some View {
        VStack {
            HStack{
                Text(TeamDetailsViewConstants.lastGamesPlayedText)
                Spacer()
                Text("2022")
            }
            LazyVGrid(columns: columns) {
                ForEach(teamDetailsViewModel.games) { game in
                    GameRow(game: game)
                }
            }
        }
        .padding()
    }
}

struct GameRow: View {
    var game: Game

    var body: some View {
        HStack (spacing: 0){
            GameCell(team: game.homeTeam, score: game.homeTeamScore)
            GameCell(team: game.visitorTeam, score: game.visitorTeamScore)
        }
    }
}

struct GameCell: View {
    var team: TeamDetails
    var score: Int
    
    var body: some View {
        HStack {
            Image(team.logoString)
                .resizable()
                .scaledToFit()
                .frame(height: 20)
            Text(team.abbreviation)
            Spacer()
            Text("\(score)")
        }
        .padding()
        .border(.white)
    }
}
