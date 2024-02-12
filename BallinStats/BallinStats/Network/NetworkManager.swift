//
//  NetworkManager.swift
//  BallinStats
//
//  Created by Gerardo Leal on 21/08/23.
//

import Foundation

class NetworkManager {
    private let session = URLSession.shared
    private let decoder = Decoder()

    static let shared: NetworkManager = NetworkManager()

    func fetchData<T: Codable>(endpoint: URL?, type: T.Type, completion: @escaping (T?) -> Void) {
        if let endpoint = endpoint {
            let urlRequest = URLRequest(url: endpoint)
            fetch(with: urlRequest, type: T.self, completion: completion)
        }
    }

    private func fetch<T: Codable>(with urlRequest: URLRequest, type: T.Type, completion: @escaping (T?) -> Void ) {
        let task = session.dataTask(with: urlRequest) { data, _, error in
            guard let data = data else {
                print("Error:  \(String(describing: error))")
                return
            }
            do {
                let model = try self.decoder.decode(from: data, type: type.self)
                DispatchQueue.main.async {
                    completion(model)
                }
            } catch let error {
                print("NetworkManager: Fetching error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
