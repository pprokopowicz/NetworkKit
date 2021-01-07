//
//  URL+Service.swift
//  
//
//  Created by Piotr Prokopowicz on 11/12/2020.
//

import Foundation

extension URL {
    
    init?<Service: NetworkingService>(service: Service) {
        var components = URLComponents(string: service.url)
        components?.queryItems = service.queryParameters?.queryItems
        
        guard let url = components?.url else { return nil }
        
        self = url
    }
    
}

fileprivate extension Dictionary where Key == String, Value == String {
    
    var queryItems: [URLQueryItem] {
        map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}

public extension NetworkingService {
    
    /// String representation of url.
    var url: String { URL(service: self)?.absoluteString ?? "" }
    
}
