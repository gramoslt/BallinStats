//
//  TeamsTabView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import SwiftUI

struct TeamsTabView: View {
    @ObservedObject var teamsTabViewModel: TeamsTabViewModel
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(TeamsTabViewModel.teamsMock, id: \.self) { team in
                        Text(team)
                    }
                }
            }
            .navigationTitle(TabViewConstants.teamsLabel)
            .background(Color("Dark-Blue-BackgroundColor"))
            .preferredColorScheme(.dark)
        }
    }
}

struct TeamsTabView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsTabView(teamsTabViewModel: TeamsTabViewModel())
    }
}
