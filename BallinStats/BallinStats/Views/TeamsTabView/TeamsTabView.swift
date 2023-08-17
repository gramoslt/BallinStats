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
                HStack {
                    Picker("Category", selection: $teamsTabViewModel.selectedFilter){
                        ForEach(Division.allCases) { division in
                                Text(division.rawValue.capitalized)
                            }
                    }
                    Spacer()
                }

                LazyVGrid(columns: columns) {
                    ForEach(TeamsTabViewModel.teamsMock, id: \.self) { team in
                        VStack {
                            Image("Heat-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            VStack {
                                Text(team)
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.red)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.yellow)
                        )
                        .padding()
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
