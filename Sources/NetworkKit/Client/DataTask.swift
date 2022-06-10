//
//  DataTask.swift
//  
//
//  Created by Piotr Prokopowicz on 10/06/2022.
//

import Foundation

public protocol DataTask {
    func resume()
    func cancel()
}

extension URLSessionDataTask: DataTask {}
