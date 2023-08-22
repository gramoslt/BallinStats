//
//  Decoder.swift
//  BallinStats
//
//  Created by Gerardo Leal on 21/08/23.
//

import Foundation

class Decoder {
    private let decoder = JSONDecoder()
    func decode<T: Codable>(from data: Data, type: T.Type) throws -> T {
        do {
            let decodedData = try decoder.decode(type.self, from: data)
            return decodedData
        } catch let error {
            print("Decoder: Decoding error: \(error)")
            throw error
        }
    }
}
