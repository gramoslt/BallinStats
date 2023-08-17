//
//  TeamsTabView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import SwiftUI

struct TeamsTabView: View {
    @ObservedObject var teamsTabViewModel: TeamsTabViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                DivisionPicker(teamsTabViewModel: teamsTabViewModel)

                TeamsDynamicGrid(teamsTabViewModel: teamsTabViewModel)
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
