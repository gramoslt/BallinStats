//
//  TeamsTabComponents.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import SwiftUI

struct DivisionPicker: View {
    @ObservedObject var teamsTabViewModel: TeamsTabViewModel

    var body: some View {
        HStack {
            Picker("Category", selection: $teamsTabViewModel.selectedFilter){
                ForEach(Division.allCases) { division in
                    Text(division.rawValue.capitalized)
                }
            }
            Spacer()
        }
        .onAppear {
            teamsTabViewModel.fetchTeams(withPage: 1)
        }
    }
}

struct TeamsDynamicGrid: View {
    @ObservedObject var teamsTabViewModel: TeamsTabViewModel
    let columns = [
        GridItem(.adaptive(minimum: TeamsTabViewConstants.columnMinimum))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(teamsTabViewModel.filteredTeams) { team in
                NavigationLink {
                    TeamDetailsOrientationView(teamDetailsViewModel: TeamDetailsViewModel(team: team))
                } label: {
                    TeamLogoButton(team: team)
                }
            }
        }
    }
}

struct TeamLogoButton: View {
    let team: TeamDetails
    
    var body: some View {
        VStack {
            Image(team.logoString)
                .resizable()
                .scaledToFit()
                .frame(width: TeamsTabViewConstants.logoWidth, height: TeamsTabViewConstants.logoHeight)
                .padding(.top)

            VStack {
                Text(team.fullName)
                    .font(.headline)
                    .foregroundColor(.redText)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.customRed)
        }
        .clipShape(RoundedRectangle(cornerRadius: TeamsTabViewConstants.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: TeamsTabViewConstants.cornerRadius)
                .stroke(.customYellowStroke)
        )
        .padding(TeamsTabViewConstants.padding)
    }
}
