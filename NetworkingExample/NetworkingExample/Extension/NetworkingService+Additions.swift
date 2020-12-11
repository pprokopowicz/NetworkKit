//
//  NetworkingService+Additions.swift
//  NetworkingExample
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation
import Networking

extension NetworkingService {
    
    typealias ErrorResponse = NetworkingEmpty
    
    static var headers: [String : String]? { ["Content-Type": "application/json"] }
    static var base: NetworkingBase { ServiceBase() }
    
}
