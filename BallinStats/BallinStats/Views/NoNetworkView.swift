//
//  NoNetworkView.swift
//  BallinStats
//
//  Created by Gerardo Leal on 29/08/23.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        VStack {
            Text(NoNetworkViewConstants.oopsText)
                .font(.largeTitle)
                .bold()
            Text(NoNetworkViewConstants.noNetworkText)
                .font(.title)
                .fontWeight(.semibold)
            Image(systemName: NoNetworkViewConstants.noNetworkIcon)
                .resizable()
                .frame(width: NoNetworkViewConstants.imageWidth,
                       height: NoNetworkViewConstants.imageHeight)
        }
    }
}

struct NoNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkView()
    }
}
