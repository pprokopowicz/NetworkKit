//
//  NetworkingService.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

/// Protocol used for storing information needed to perform a request.
public protocol NetworkingService {
    
    /// Output of which the response is being decoded into.
    associatedtype Output: Decodable
    /// Output of which the response is being decoded into when some error occurs.
    associatedtype ErrorResponse: Decodable
    
    /// Method which is used.
    static var method: HTTPMethod { get }
    /// Headers used for service calls. Default value is `nil`.
    static var headers: [String: String]? { get }
    /// Base url for given service.
    static var base: NetworkingBase { get }

    /// Endpoint path For example: "/api/breeds/image/random".
    var path: String { get }
    /// Optional query parameters that are added to the url.
    var queryParameters: [String: String]? { get }
    /// Optional body input. Must confrom to `Encodable`. 
    var input: Encodable? { get }
    
}

public extension NetworkingService {
    
    /// nil
    static var headers: [String: String]? { nil }
    /// nil
    var queryParameters: [String: String]? { nil }
    /// nil
    var input: Encodable? { nil }
    /// String representation of url.
    var url: String { "\(Self.base.url)\(path)" }
    
}
