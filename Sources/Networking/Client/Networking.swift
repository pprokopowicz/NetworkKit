//
//  Networking.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation
#warning ("TODO: Documentation")
public struct Networking {
    
    public let timeout: TimeInterval?
    public let encoder: JSONEncoder
    public let decoder: JSONDecoder
    
    public init(timeout: TimeInterval? = nil, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.timeout = timeout
        self.encoder = encoder
        self.decoder = decoder
    }
    
}
