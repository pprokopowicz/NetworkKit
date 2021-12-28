//
//  TodoModel.swift
//  NetworkKitExample
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation

struct TodoModel: Decodable {
    
    let id: Int
    let title: String
    let completed: Bool
    
}
