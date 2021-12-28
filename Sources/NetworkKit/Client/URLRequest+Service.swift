//
//  URLRequest+Service.swift
//  
//
//  Created by Piotr Prokopowicz on 11/12/2020.
//

import Foundation

extension URLRequest {
    
    public init?<Service: NetworkService>(service: Service, encoder: JSONEncoder = JSONEncoder(), timeout: TimeInterval? = nil) {
        guard let url = URL(service: service) else { return nil }
        self.init(url: url)
        allHTTPHeaderFields = Service.headers?.mapValues { $0.description }
        httpMethod = Service.method.rawValue
        
        if let timeout = timeout {
            timeoutInterval = timeout
        }
        
        if Service.method != .get {
            httpBody = service.body?.data(encoder: encoder)
        }
    }
    
}

fileprivate extension Encodable {
    
    func data(encoder: JSONEncoder = JSONEncoder()) -> Data? {
        try? encoder.encode(self)
    }
    
}
