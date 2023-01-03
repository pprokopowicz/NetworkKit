//
//  PreRequestMiddleware.swift
//  
//
//  Created by Piotr Prokopowicz on 03/01/2023.
//

import Foundation

/// Protocol used to extend the functionality of `NetworkClient`.
public protocol Middleware {
    /// Prepare function is called right before request is being sent. You can use it to modify the request.
    ///
    /// - Parameter request: Original `NetworkRequest`.
    /// - Parameter urlRequest: `URLRequest` built by `NetworkClient` based on `NetworkRequest`.
    /// - Returns: Request that will be sent. If you don't want to modify the request you can just return `urlRequest` from parameters.
    func prepare<Request: NetworkRequest>(request: Request, urlRequest: URLRequest) -> URLRequest

    /// Process function is called right after receiving a response. You can use it to modify the result.
    ///
    /// - Parameter client: `NetworkClient` object that performs the request. You can use it to perform additional requests if needed.
    /// - Parameter request: Original `NetworkRequest`.
    /// - Parameter urlRequest: `URLRequest` built by `NetworkClient` based on `NetworkRequest`.
    /// - Parameter result: Result of the call.
    /// - Parameter data: Original `Data` returned from the call.
    /// - Parameter response: Original `URLResponse` returned from the call.
    /// - Returns: Result of the call. If you don't want to modify the request you can just return `result` from parameters.
    func process<Request: NetworkRequest>(
        client: NetworkClient,
        request: Request,
        urlRequest: URLRequest,
        result: Result<Request.Output, Error>,
        data: Data?,
        response: URLResponse?
    ) async -> Result<Request.Output, Error>
}

public extension Middleware {
    func prepare<Request: NetworkRequest>(request: Request, urlRequest: URLRequest) -> URLRequest {
        urlRequest
    }
    
    func process<Request: NetworkRequest>(
        client: NetworkClient,
        request: Request,
        urlRequest: URLRequest,
        result: Result<Request.Output, Error>,
        data: Data?,
        response: URLResponse?,
        completion: (Result<Request.Output, Error>) -> Void
    ) {
        completion(result)
    }
}
