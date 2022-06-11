//
//  DataTask.swift
//  
//
//  Created by Piotr Prokopowicz on 10/06/2022.
//

import Foundation

/// Protocol used as a return type of request function in `NetworkClient`.
public protocol DataTask {
    /// Starts a new request call.
    func resume()
    /// Cancels request call.
    func cancel()
}

extension URLSessionDataTask: DataTask {}
