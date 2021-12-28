//
//  URL+Service.swift
//  
//
//  Created by Piotr Prokopowicz on 11/12/2020.
//

import Foundation

extension URL {
    
    public init?<Service: NetworkService>(service: Service) {
        var components = URLComponents(string: "\(service.environment.baseURL)\(service.path)")
        components?.queryItems = service.queryParameters?.queryItems
        
        guard let url = components?.url else { return nil }
        
        self = url
    }
    
}

fileprivate extension Dictionary where Key == String, Value == CustomStringConvertible {
    
    var queryItems: [URLQueryItem] {
        map { URLQueryItem(name: $0.key, value: $0.value.description) }
    }
    
}

public extension NetworkService {
    
    /// String representation of url.
    var url: String { URL(service: self)?.absoluteString ?? "" }
    
}
