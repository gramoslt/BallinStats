//
//  FollowingTabView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import SwiftUI

struct FollowingTabView: View {
    @ObservedObject var followingTabViewModel: FollowingTabViewModel

    var body: some View {
        NavigationStack {
            TeamsList(followingTabViewModel: followingTabViewModel)
        }
    }
}

struct FollowingTabView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingTabView(followingTabViewModel: FollowingTabViewModel())
    }
}
