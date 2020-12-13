//
//  URLRequest+Service.swift
//  
//
//  Created by Piotr Prokopowicz on 11/12/2020.
//

import Foundation

extension URLRequest {
    
    init?<Service: NetworkingService>(service: Service, encoder: JSONEncoder = JSONEncoder(), timeout: TimeInterval? = nil) {
        guard let url = URL(service: service) else { return nil }
        self.init(url: url)
        allHTTPHeaderFields = Service.headers
        httpMethod = Service.method.rawValue
        
        if let timeout = timeout {
            timeoutInterval = timeout
        }
        
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
