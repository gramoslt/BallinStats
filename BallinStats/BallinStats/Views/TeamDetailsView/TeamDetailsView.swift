//
//  TeamDetailsView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import SwiftUI

struct TeamDetailsView: View {
    var team: TeamDetails

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
            }
            .navigationTitle(team.fullName)
        }
    }
}

struct TeamDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsView(team: TeamDetails.mockLAL)
    }
}
