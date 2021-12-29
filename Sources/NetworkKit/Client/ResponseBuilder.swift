//
//  ResponseBuilder.swift
//  
//
//  Created by Piotr Prokopowicz on 29/12/2021.
//

import Foundation

// MARK: - Protocol

public protocol ResponseBuilderScheme {
    func response<Request: NetworkRequest>(from request: Request, data: Data?, response: URLResponse?, error: Error?) -> Result<Request.Output, Error>
}

// MARK: - Implementation

public struct ResponseBuilder: ResponseBuilderScheme {
    
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    public func response<Request: NetworkRequest>(
        from request: Request,
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) -> Result<Request.Output, Error> {
        if let error = error {
            return .failure(error)
        }
        
        guard let httpURLResponse = response as? HTTPURLResponse else {
            let errorResponse = data.map { try? self.decoder.decode(Request.ErrorResponse.self, from: $0) }
            return .failure(NetworkError(status: .unknown, response: errorResponse))
        }
        
        guard 200...299 ~= httpURLResponse.statusCode else {
            let errorResponse = data.map { try? self.decoder.decode(Request.ErrorResponse.self, from: $0) }
            let status = NetworkResponseStatus(rawValue: httpURLResponse.statusCode) ?? .unknown
            return .failure(NetworkError(status: status, response: errorResponse))
        }
        
        guard let data = data else {
            return .failure(NetworkError<Request.ErrorResponse>(status: .unableToParseResponse, response: nil))
        }
        
        do {
            let model = try self.decoder.decode(Request.Output.self, from: data)
            return .success(model)
        } catch(let error) {
            return .failure(error)
        }
    }
    
}
