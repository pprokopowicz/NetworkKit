//
//  Networking+Additions.swift
//  NetworkingExample
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation
import Networking

extension NetworkingProvider {
    
    static let shared: NetworkingProvider = {
        NetworkingProvider()
    }()
    
}
