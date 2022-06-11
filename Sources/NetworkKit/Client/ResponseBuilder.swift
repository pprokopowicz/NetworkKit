//
//  ResponseBuilder.swift
//  
//
//  Created by Piotr Prokopowicz on 29/12/2021.
//

import Foundation

// MARK: - Protocol

/// Protocol used to separate creation of response object from `NetworkClient`.
public protocol ResponseBuilderScheme {
    func response<Output: Decodable, ErrorOutput: Decodable>(
        _ outputType: Output.Type,
        errorType: ErrorOutput.Type,
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) -> Result<Output, Error>
}

// MARK: - Implementation

public struct ResponseBuilder: ResponseBuilderScheme {
    
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    public func response<Output: Decodable, ErrorOutput: Decodable>(
        _ outputType: Output.Type,
        errorType: ErrorOutput.Type,
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) -> Result<Output, Error> {
        if let error = error {
            return .failure(error)
        }
        
        guard let httpURLResponse = response as? HTTPURLResponse else {
            let errorResponse = data.map { try? self.decoder.decode(errorType, from: $0) }
            return .failure(NetworkError(status: .unknown, response: errorResponse))
        }
        
        guard 200...299 ~= httpURLResponse.statusCode else {
            let errorResponse = data.map { try? self.decoder.decode(outputType, from: $0) }
            let status = NetworkResponseStatus(rawValue: httpURLResponse.statusCode) ?? .unknown
            return .failure(NetworkError(status: status, response: errorResponse))
        }
        
        guard let data = data else {
            return .failure(NetworkError<ErrorOutput>(status: .unableToParseResponse, response: nil))
        }
        
        do {
            let model = try self.decoder.decode(outputType, from: data)
            return .success(model)
        } catch(let error) {
            return .failure(error)
        }
    }
    
}
