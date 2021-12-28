//
//  Networking.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation

/// Struct that is responsible for creating api calls. It's built on top of `URLSession`.
public struct NetworkClient {
    
    /// Timeout of requests.
    public let timeout: TimeInterval?
    /// `JSONEncoder` used to encode body of request.
    public let encoder: JSONEncoder
    /// `JSONDecoder` used to decode service response.
    public let decoder: JSONDecoder
    
    /// Initializes client with given parameters. Every parameter has default value.
    ///
    /// - Parameter timeout: Timeout of requests.
    /// - Parameter encoder: `JSONEncoder` used to encode body of request.
    /// - Parameter decoder: `JSONDecoder` used to decode service response.
    public init(timeout: TimeInterval? = nil, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.timeout = timeout
        self.encoder = encoder
        self.decoder = decoder
    }
    
}
