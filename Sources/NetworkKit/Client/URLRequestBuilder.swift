//
//  URLRequestBuilder.swift
//  
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation

// MARK: - Protocol

public protocol URLRequestBuilderScheme {
    func request<Request: NetworkRequest>(from request: Request, encoder: JSONEncoder, timeout: TimeInterval?) -> URLRequest?
}

public protocol URLBuilderScheme {
    func url<Request: NetworkRequest>(from request: Request) -> URL?
}

// MARK: - Implementation

public struct URLRequestBuilder: URLRequestBuilderScheme {
    
    private let urlBuilder: URLBuilderScheme

    public init(urlBuilder: URLBuilderScheme = URLBuilder()) {
        self.urlBuilder = urlBuilder
    }
    
    public func request<Request: NetworkRequest>(from request: Request, encoder: JSONEncoder, timeout: TimeInterval? = nil) -> URLRequest? {
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

public struct URLBuilder: URLBuilderScheme {
    
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
