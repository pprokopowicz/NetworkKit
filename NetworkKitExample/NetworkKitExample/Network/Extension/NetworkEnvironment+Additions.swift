//
//  NetworkEnvironment+Additions.swift
//  NetworkKitExample
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation
import NetworkKit

extension NetworkEnvironment where Self == NetworkSimpleEnvironment {
    static var `default`: NetworkEnvironment { NetworkSimpleEnvironment(baseURL: "https://jsonplaceholder.cypress.io") }
}
