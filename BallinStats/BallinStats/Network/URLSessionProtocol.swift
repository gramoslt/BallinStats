//
//  URLSessionScheme.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/09/23.
//

import Foundation

protocol URLSessionProtocol {

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLSessionProtocol {

    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task: URLSessionDataTask = dataTask(with: urlRequest) { (data, response, error) in
                completionHandler(data, response, error)
        }
        task.resume()
    }
}

class URLSessionMock: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(nil, nil, nil)
    }
}
