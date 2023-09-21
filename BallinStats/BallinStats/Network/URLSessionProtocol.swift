//
//  URLSessionScheme.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/09/23.
//

import Foundation

protocol URLSessionProtocol {
    associatedtype DataTaskType
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskType
}

extension URLSession: URLSessionProtocol {
    typealias DataTaskType = URLSessionDataTask
}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    typealias CompletionHandler = URLSessionMock.CompletionHandler
    private let completion: CompletionHandler

    init(completion: @escaping CompletionHandler) {
        self.completion = completion
    }

    func resume() {
        completion()
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

class URLSessionMock: URLSessionProtocol {
    typealias DataTaskType = URLSessionDataTaskMock

    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    var response: URLResponse?

    func dataTask(with: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskMock {
        return URLSessionDataTaskMock(completion: completionHandler)
    }
}

let urlSessionMock = URLSessionMock()
let url = URL(string: "")!
let urlRequest = URLRequest(url: url)
urlSessionMock.dataTask(with: urlRequest) { data, response, error in
    <#code#>
}
