//
//  URLRequestBuilder.swift
//  
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation

// MARK: - Protocol

/// Protocol used to separate creation of `URLRequest` object from `NetworkClient`.
public protocol URLRequestBuilderScheme {
    func request<Request: NetworkRequest>(from request: Request) -> URLRequest?
}

// MARK: - Implementation

public struct URLRequestBuilder: URLRequestBuilderScheme {
    
    private let encoder: JSONEncoder

    public init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }
    
    public func request(from request: some NetworkRequest) -> URLRequest? {
        guard let url = url(from: request) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.headers?.mapValues(\.description)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body?.data(encoder: encoder)
        if let timeout = request.timeout {
            urlRequest.timeoutInterval = timeout
        }
        
        return urlRequest
    }
    
    private func url(from request: some NetworkRequest) -> URL? {
        var components = URLComponents(string: "\(request.environment.baseURL)\(request.path)")
        components?.queryItems = request.queryParameters?.queryItems
        return components?.url
    }
    
}

// MARK: - Extension

fileprivate extension Dictionary where Key == String, Value == CustomStringConvertible {

    var queryItems: [URLQueryItem] {
        map { URLQueryItem(name: $0.key, value: $0.value.description) }
    }

}

fileprivate extension Encodable {

    func data(encoder: JSONEncoder = JSONEncoder()) -> Data? {
        try? encoder.encode(self)
    }

}
