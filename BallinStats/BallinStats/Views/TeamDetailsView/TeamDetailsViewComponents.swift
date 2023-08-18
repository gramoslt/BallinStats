//
//  TeamDetailsViewComponents.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/08/23.
//

import SwiftUI

struct TeamLogo: View {
    let logoString: String

    var body: some View {
        Image(logoString)
            .resizable()
            .scaledToFit()
            .frame(width: TeamDetailsViewConstants.logoWidth)
    }
}

struct TeamAbbreviation: View {
    let abbreviation: String

    var body: some View {
        HStack{
            Text(abbreviation)
                .font(.title)
                .bold()
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct TeamInfo: View {
    let team: TeamDetails

    var body: some View {
        HStack (alignment: .lastTextBaseline){
            VStack (alignment: .leading){
                Text(team.city)
                    .font(.title)
                    .bold()
                Text(team.conference)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            Spacer()
            Text(team.division)
                .font(.title2)
                .fontWeight(.semibold)
        }
        .padding()
    }
}

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
                SeasonPicker(teamDetailsViewModel: teamDetailsViewModel)
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
                .frame(height: TeamDetailsViewConstants.gridLogoHeight)
            Text(team.abbreviation)
            Spacer()
            Text("\(score)")
                .bold()
        }
        .padding()
        .border(.white)
    }
}

struct SeasonPicker: View {
    @ObservedObject var teamDetailsViewModel: TeamDetailsViewModel

    var body: some View {
        Picker("Season", selection: $teamDetailsViewModel.selectedYear) {
            ForEach(1990 ..< 2023) { year in
                Text("Season \(String(year))")
                    .tag(year)
            }
        }
        .pickerStyle(.menu)
    }
}
