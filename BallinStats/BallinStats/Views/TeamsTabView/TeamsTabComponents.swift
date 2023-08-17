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
    }
}

struct TeamsDynamicGrid: View {
    @ObservedObject var teamsTabViewModel: TeamsTabViewModel
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(TeamsTabViewModel.teamsMock) { team in
                VStack {
                    Image(team.logoString)
                        .resizable()
                        .scaledToFit()
                        .frame(width: TeamsTabViewConstants.logoWidth, height: TeamsTabViewConstants.logoHeight)
                    
                    VStack {
                        Text(team.fullName)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color("RedAccentColor"))
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("StrokeColor"))
                )
                .padding(10)
            }
        }
    }
}
