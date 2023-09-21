//
//  NetworkManager.swift
//  BallinStats
//
//  Created by Gerardo Leal on 21/08/23.
//

import Foundation

protocol NetworkManager {
    typealias NetworkResult<T> = Result<T, ErrorHandler.NetworkError>
    var session: URLSession { get }

    func fetchData<T: Codable>(endpoint: URL?, type: T.Type, completion: @escaping (NetworkResult<T>) -> Void)

    func handleResponse<T: Codable>(type: T.Type,
                                    data: Data?,
                                    response: URLResponse?,
                                    completion: @escaping (NetworkResult<T>) -> Void)

    func handleData<T: Codable>(type: T.Type, data: Data?, completion: @escaping (NetworkResult<T>) -> Void)
}

class MockNetworkManager: NetworkManager {
    
    var session: URLSessionProtocol

    func handleResponse<T: Codable>(type: T.Type, data: Data?, response: URLResponse?, completion: @escaping (NetworkResult<T>) -> Void) {
        // lo que hace mi funcion
    }

    func handleData<T: Codable>(type: T.Type, data: Data?, completion: @escaping (NetworkResult<T>) -> Void) {
        // lo que hace mi funcion
    }

    func fetchData<T: Codable>(endpoint: URL?, type: T.Type, completion: @escaping (NetworkResult<T>) -> Void) {
        // lo que hace mi funcion
    }
}

class LiveNetworkManager: NetworkManager {

    internal let session : URLSession
    static let shared: LiveNetworkManager = LiveNetworkManager()

    init (
        session: URLSession = URLSession.shared
    ) {
        self.session = session
    }

    func fetchData<T: Codable>(endpoint: URL?, type: T.Type, completion: @escaping (NetworkResult<T>) -> Void) {
        guard let url = endpoint else {
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.handleResponse(type: type, data: data, response: response, completion: completion)
            }
        }
        task.resume()
    }

    internal func handleResponse<T: Codable>(type: T.Type, data: Data?, response: URLResponse?, completion: @escaping (NetworkResult<T>) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(.unknown))
            return
        }

        switch httpResponse.statusCode {
        case 200...299:
            handleData(type: type, data: data, completion: completion)
        case 404:
            completion(.failure(.notFound))
        default:
            completion(.failure(.unknown))
        }
    }

    internal func handleData<T: Codable>(type: T.Type, data: Data?, completion: @escaping (NetworkResult<T>) -> Void) {
        guard let data = data else {
            completion(.failure(.unknown))
            return
        }
        let decoder = Decoder()
        do {
            let model = try decoder.decode(from: data, type: type.self)
            completion(.success(model))
        } catch let error {
            print("NetworkManager: Decoding error: \(error)")
            completion(.failure(.unknown))
        }
    }
}