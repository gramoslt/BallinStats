//
//  PlayerDetailsView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 17/08/23.
//

import SwiftUI

struct PlayerDetailsView: View {
    var player: Player

    var body: some View {
        Text(player.fullName)
    }
}

struct PlayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsView(player: Player.mock)
    }
}
