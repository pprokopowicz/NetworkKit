//
//  TodoService.swift
//  NetworkingExample
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation
import Networking

struct TodoService: NetworkingService {
    
    typealias Output = [TodoModel]
    
    static var method: HTTPMethod { .get }
    
    var path: String { "/todos" }
    
}
