//
//  ErrorHandler.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/09/23.
//

import Foundation

struct ErrorHandler {
    enum NetworkError: Error {
        case notFound
        case badRequest
        case serverError
        case unknown
        case badResponse
        case decodingError
        case badURL
        case noDataError
    }
}
