//
//  NetworkEnvironment+Additions.swift
//  NetworkKitExample
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation
import NetworkKit

extension NetworkEnvironment {
    static let `default`: NetworkEnvironment = NetworkEnvironment(baseURL: "https://jsonplaceholder.cypress.io")
}
