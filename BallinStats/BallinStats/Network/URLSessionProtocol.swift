//
//  URLSessionScheme.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/09/23.
//

import Foundation

protocol URLSessionProtocol {

    func dataTask(with request: URLRequest, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> Resumable
}

extension URLSession: URLSessionProtocol {

    func dataTask(with request: URLRequest, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> Resumable {
                return dataTask(with: request, completionHandler: completion)
    }
}

protocol Resumable {
    func resume()
}

extension URLSessionDataTask: Resumable { }

class MockURLSessionDataTask: Resumable {
    func resume() { }
}

class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
    }

    func dataTask(with request: URLRequest, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> Resumable {
        completion(data, response, error)
        return MockURLSessionDataTask()
    }
}
