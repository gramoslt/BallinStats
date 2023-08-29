//
//  NetworkMonitor.swift
//  BallinStats
//
//  Created by Gerardo Leal on 29/08/23.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    @Published var isConnected = false
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue

    init(
        monitor: NWPathMonitor,
        queue: DispatchQueue
    ) {
        self.monitor = monitor
        self.queue = queue
    }

    convenience init() {
        self.init(
            monitor: .init(),
            queue: .init(label: NetworkMonitorConstants.networkMonitor)
        )
        self.beginChecking()
    }

    private func beginChecking() {
        debugPrint(NetworkMonitorConstants.networkMonitor, #function)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.pathHandler(path: path)
            }
        }
    }

    private func pathHandler(path: NWPath) {
        debugPrint(NetworkMonitorConstants.networkMonitorStatus, path.status)
        switch path.status {
        case .satisfied:
            isConnected = true
        default:
            isConnected = false
        }
    }

    deinit {
        debugPrint(NetworkMonitorConstants.networkMonitor, #function)
        monitor.cancel()
    }
}

#if DEBUG
extension NetworkMonitor {
    convenience init(isConnected: Bool) {
        self.init(
            monitor: .init(),
            queue: .init(label: NetworkMonitorConstants.networkMonitorMock)
        )
        self.isConnected = isConnected
    }
}
#endif
