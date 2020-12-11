//
//  URL+Service.swift
//  
//
//  Created by Piotr Prokopowicz on 11/12/2020.
//

import Foundation

extension URL {
    
    init?<Service: NetworkingService>(service: Service) {
        var components = URLComponents(string: "\(Service.base.url)\(service.path)")
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
