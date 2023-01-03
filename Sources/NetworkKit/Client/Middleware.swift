//
//  PreRequestMiddleware.swift
//  
//
//  Created by Piotr Prokopowicz on 03/01/2023.
//

import Foundation

public protocol Middleware {
    func prepare<Request: NetworkRequest>(request: Request, urlRequest: URLRequest) -> URLRequest
    func process<Request: NetworkRequest>(request: Request, result: Result<Request.Output, Error>) -> Result<Request.Output, Error>
}

public extension Middleware {
    func prepare<Request: NetworkRequest>(request: Request, urlRequest: URLRequest) -> URLRequest {
        urlRequest
    }
    
    func process<Request: NetworkRequest>(request: Request, result: Result<Request.Output, Error>) -> Result<Request.Output, Error> {
        result
    }
}
