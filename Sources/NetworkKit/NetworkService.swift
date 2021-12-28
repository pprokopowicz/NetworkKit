//
//  NetworkService.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

/// Protocol used for storing information needed to perform a request.
public protocol NetworkService {
    
    /// Output of which the response is being decoded into.
    associatedtype Output: Decodable
    /// Output of which the response is being decoded into when some error occurs.
    associatedtype ErrorResponse: Decodable
    
    /// Method which is used.
    static var method: HTTPMethod { get }
    /// Headers used for service calls.
    static var headers: [String: CustomStringConvertible]? { get }
    /// Base url for given service.
    static var environment: NetworkEnvironment { get }

    /// Endpoint path For example: "/api/breeds/image/random".
    var path: String { get }
    /// Optional query parameters that are added to the url.
    var queryParameters: [String: CustomStringConvertible]? { get }
    /// Optional body input. Must confrom to `Encodable`. 
    var body: Encodable? { get }
    
}

public extension NetworkService {
    
    /// nil
    static var headers: [String: CustomStringConvertible]? { nil }
    /// nil
    var queryParameters: [String: CustomStringConvertible]? { nil }
    /// nil
    var input: Encodable? { nil }
    
}
