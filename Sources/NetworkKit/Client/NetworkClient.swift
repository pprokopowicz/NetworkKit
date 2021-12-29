//
//  Networking.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation

/// Struct that is responsible for creating api calls. It's built on top of `URLSession`.
public final class NetworkClient {
    
    /// Object used to build `URLRequest` from `NetworkRequest`.
    public let requestBuilder: URLRequestBuilderScheme
    /// Object used to build response from returned data.
    public let responseBuilder: ResponseBuilderScheme
    
    /// Initializes client with given parameters. Every parameter has default value.
    ///
    /// - Parameter requestBuilder: Object used to build `URLRequest` from `NetworkRequest`.
    /// - Parameter responseBuilder: Object used to build response from returned data.
    public init(
        requestBuilder: URLRequestBuilderScheme = URLRequestBuilder(),
        responseBuilder: ResponseBuilderScheme = ResponseBuilder()
    ) {
        self.requestBuilder = requestBuilder
        self.responseBuilder = responseBuilder
    }
    
}
