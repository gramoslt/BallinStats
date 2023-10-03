//
//  URLSessionScheme.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/09/23.
//

import Foundation

protocol URLSessionProtocol {

    func dataTask(with request: URLRequest, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {

    func dataTask(with request: URLRequest, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
                return dataTask(with: request, completionHandler: completion)
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
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

    func dataTask(with request: URLRequest, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completion(data, response, error)
        return MockURLSessionDataTask()
    }
}

class MockResponse {
    static func createResponse(urlString: String,statusCode: Int)-> HTTPURLResponse{
        HTTPURLResponse(
            url: URL(string: urlString)!,
            statusCode: statusCode,
            httpVersion: "1.1",
            headerFields: nil
        )!
    }
}
