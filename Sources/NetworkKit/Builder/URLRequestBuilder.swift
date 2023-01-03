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
    func request(from request: some NetworkRequest) -> Result<URLRequest, Error>
}

// MARK: - Implementation

public struct URLRequestBuilder: URLRequestBuilderScheme {
    
    private let jsonBodyEncoder: BodyEncoderScheme

    public init(
        jsonBodyEncoder: BodyEncoderScheme = BodyEncoder()
    ) {
        self.jsonBodyEncoder = jsonBodyEncoder
    }
    
    public func request(from request: some NetworkRequest) -> Result<URLRequest, Error> {
        guard let url = url(from: request) else { return .failure(NetworkError<NetworkEmpty>(status: .unableToParseRequest, response: nil)) }
        
        var urlRequest = URLRequest(url: url)
        switch body(from: request) {
        case .success(let data):
            urlRequest.httpBody = data
        case .failure(let error):
            return .failure(error)
        }
        urlRequest.allHTTPHeaderFields = request.headers?.mapValues(\.description)
        urlRequest.httpMethod = request.method.rawValue
        if let timeout = request.timeout {
            urlRequest.timeoutInterval = timeout
        }
        
        return .success(urlRequest)
    }
    
    private func url(from request: some NetworkRequest) -> URL? {
        var components = URLComponents(string: "\(request.environment.baseURL)\(request.path)")
        components?.queryItems = request.queryParameters?.queryItems
        return components?.url
    }

    private func body(from request: some NetworkRequest) -> Result<Data?, Error> {
        switch request.body {
        case .some(let encodableObject):
            switch jsonBodyEncoder.encode(object: encodableObject) {
            case .success(let data):
                return .success(data)
            case .failure(let error):
                return .failure(error)
            }
        case .none:
            return .success(nil)
        }
    }
    
}

// MARK: - Extension

fileprivate extension Dictionary where Key == String, Value == CustomStringConvertible {

    var queryItems: [URLQueryItem] {
        map { URLQueryItem(name: $0.key, value: $0.value.description) }
    }

}
