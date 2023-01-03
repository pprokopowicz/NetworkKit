//
//  PreRequestMiddleware.swift
//  
//
//  Created by Piotr Prokopowicz on 03/01/2023.
//

import Foundation

public protocol Middleware {
    func prepare<Request: NetworkRequest>(request: Request, urlRequest: URLRequest) -> URLRequest
    
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
