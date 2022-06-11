//
//  NetworkRequest.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation

/// Protocol used for storing information needed to perform a request.
public protocol NetworkRequest {
    
    /// Output of which the response is being decoded into.
    associatedtype Output: Decodable
    /// Output of which the response is being decoded into when some error occurs.
    associatedtype ErrorResponse: Decodable
    
    /// Method which is used.
    var method: HTTPMethod { get }
    /// Headers used for service calls.
    var headers: [String: CustomStringConvertible]? { get }
    /// Base url for given service.
    var environment: NetworkEnvironment { get }

    /// Endpoint path For example: "/api/breeds/image/random".
    var path: String { get }
    /// Optional query parameters that are added to the url.
    var queryParameters: [String: CustomStringConvertible]? { get }
    /// Optional body input. Must confrom to `Encodable`. 
    var body: BodyEncoding? { get }
    /// Request timeout.
    var timeout: TimeInterval?  { get }
    
}

public extension NetworkRequest {
    
    /// nil
    var headers: [String: CustomStringConvertible]? { nil }
    /// nil
    var queryParameters: [String: CustomStringConvertible]? { nil }
    /// nil
    var body: Encodable? { nil }
    /// nil
    var timeout: TimeInterval? { nil }
}
