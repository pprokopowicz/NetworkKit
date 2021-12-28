//
//  Networking.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation

/// Struct that is responsible for creating api calls. It's built on top of `URLSession`.
public final class NetworkClient {
    
    /// Timeout of requests.
    public let timeout: TimeInterval?
    /// `JSONEncoder` used to encode body of request.
    public let encoder: JSONEncoder
    /// `JSONDecoder` used to decode service response.
    public let decoder: JSONDecoder
    /// Object used to build `URLRequest` from `NetworkRequest`.
    public let requestBuilder: URLRequestBuilderScheme
    
    /// Initializes client with given parameters. Every parameter has default value.
    ///
    /// - Parameter timeout: Timeout of requests.
    /// - Parameter encoder: `JSONEncoder` used to encode body of request.
    /// - Parameter decoder: `JSONDecoder` used to decode service response.
    /// - Parameter requestBuilder: Object used to map `NetworkRequest` to `URLRequest`.
    public init(
        timeout: TimeInterval? = nil,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder(),
        requestBuilder: URLRequestBuilderScheme = URLRequestBuilder()
    ) {
        self.timeout = timeout
        self.encoder = encoder
        self.decoder = decoder
        self.requestBuilder = requestBuilder
    }
    
}
