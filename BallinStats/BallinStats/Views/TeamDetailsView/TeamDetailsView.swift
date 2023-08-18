//
//  TeamDetailsView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import SwiftUI

struct TeamDetailsView: View {
    var team: TeamDetails
    @StateObject var teamDetailsViewModel = TeamDetailsViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                HStack{
                    Text(team.abbreviation)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.horizontal)
                
                Image(team.logoString)
                    .resizable()
                    .scaledToFit()
                    .frame(width: TeamDetailsViewConstants.logoWidth)
                
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
                
                GamesPlayedGrid(teamDetailsViewModel: teamDetailsViewModel)
            }
            .navigationTitle(team.fullName)
            .background(.customBackgroundColor)
        }
        .preferredColorScheme(.dark)
    }
}

struct TeamDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsView(team: TeamDetails.mockLAL)
    }
}
