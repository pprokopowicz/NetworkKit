//
//  NetworkEnvironment.swift
//  
//
//  Created by Piotr Prokopowicz on 11/12/2020.
//

/// Used to declare a base url for service.
public struct NetworkEnvironment {
    
    public let baseURL: String

    public init(baseURL: String) {
        self.baseURL = baseURL
    }
    
}
