//
//  BallinStatsApp.swift
//  BallinStats
//
//  Created by Gerardo Leal on 16/08/23.
//

import SwiftUI

@main
struct BallinStatsApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            TabNavigationView()
                .onAppear{
                    CoreDataManager.shared.load()
                }
                .environmentObject(networkMonitor)
        }
    }
}
