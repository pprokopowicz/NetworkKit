//
//  NetworkClient+Additions.swift
//  NetworkKitExample
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation
import NetworkKit
import NetworkKitLogMiddleware

extension NetworkClient {
    static let shared: NetworkClient = NetworkClient(middleware: [NetworkLogMiddleware()])
}
