//
//  EndpointBuilder.swift
//  BallinStats
//
//  Created by Gerardo Leal on 21/08/23.
//

import Foundation

class EndpointBuilder {
    private var components: URLComponents

    init(components: URLComponents = URLComponents()) {
        self.components = components
        self.components.scheme = "https"
        self.components.host = "www.balldontlie.io"
        self.components.path = "/api/v1"
    }
}
