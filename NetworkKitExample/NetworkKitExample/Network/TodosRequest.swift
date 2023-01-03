//
//  TodosRequest.swift
//  NetworkKitExample
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation
import NetworkKit

struct TodoService: NetworkRequest {
    typealias Output = [TodoModel]
    
    let method: HTTPMethod = .get
    let path: String = "/todos"
    let environment: NetworkEnvironment = .default
    
}
