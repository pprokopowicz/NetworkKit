//
//  URLRequest+Service.swift
//  
//
//  Created by Piotr Prokopowicz on 11/12/2020.
//

import Foundation

extension URLRequest {
    
    init?<Service: NetworkingService>(service: Service, encoder: JSONEncoder) {
        guard let url = URL(service: service) else { return nil }
        self.init(url: url)
        allHTTPHeaderFields = Service.headers
        httpMethod = Service.method.rawValue
        
        if Service.method != .get {
            httpBody = service.input?.data(encoder: encoder)
        }
    }
    
}

fileprivate extension Encodable {
    
    func data(encoder: JSONEncoder = JSONEncoder()) -> Data? {
        try? encoder.encode(self)
    }
    
}
