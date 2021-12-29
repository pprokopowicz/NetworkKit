//
//  URLRequestBuilder.swift
//  
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation

// MARK: - Protocol

internal protocol URLRequestBuilderScheme {
    func request<Request: NetworkRequest>(from request: Request) -> URLRequest?
}

internal protocol URLBuilderScheme {
    func url<Request: NetworkRequest>(from request: Request) -> URL?
}

// MARK: - Implementation

internal struct URLRequestBuilder: URLRequestBuilderScheme {
    
    private let urlBuilder: URLBuilderScheme
    private let encoder: JSONEncoder
    private let timeout: TimeInterval?

    internal init(
        urlBuilder: URLBuilderScheme = URLBuilder(),
        encoder: JSONEncoder = JSONEncoder(),
        timeout: TimeInterval? = nil
    ) {
        self.urlBuilder = urlBuilder
        self.encoder = encoder
        self.timeout = timeout
    }
    
    internal func request<Request: NetworkRequest>(from request: Request) -> URLRequest? {
        guard let url = urlBuilder.url(from: request) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.headers?.mapValues(\.description)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body?.data(encoder: encoder)
        if let timeout = timeout {
            urlRequest.timeoutInterval = timeout
        }
        
        return urlRequest
    }
    
}

internal struct URLBuilder: URLBuilderScheme {
    
    public init() {}
    
    public func url<Request: NetworkRequest>(from request: Request) -> URL? {
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
