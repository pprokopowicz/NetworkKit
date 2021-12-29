//
//  Cancellable.swift
//  
//
//  Created by Piotr Prokopowicz on 28/06/2021.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {}
