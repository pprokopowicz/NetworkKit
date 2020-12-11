//
//  TodoModel.swift
//  NetworkingExample
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation

struct TodoModel: Decodable {
    
    let id: Int
    let title: String
    let completed: Bool
    
}
