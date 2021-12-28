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
    /// Array of `NetworkPlugin` used to add additional functionality to instance of this struct.
    public let plugins: [NetworkPlugin]
    
    /// Initializes client with given parameters. Every parameter has default value.
    ///
    /// - Parameter timeout: Timeout of requests.
    /// - Parameter encoder: `JSONEncoder` used to encode body of request.
    /// - Parameter decoder: `JSONDecoder` used to decode service response.
    /// - Parameter plugins: Array of `NetworkingPlugin` used to add additional functionality to instance of this struct.
    public init(timeout: TimeInterval? = nil, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder(), plugins: [NetworkPlugin] = []) {
        self.timeout = timeout
        self.encoder = encoder
        self.decoder = decoder
        self.plugins = plugins
    }
    
}
