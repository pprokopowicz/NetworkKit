//
//  NetworkRequest+Additions.swift
//  NetworkKitExample
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation
import NetworkKit

extension NetworkRequest {
    typealias ErrorResponse = NetworkEmpty
    var headers: [String : CustomStringConvertible]? { ["Content-Type": "application/json"] }
}
