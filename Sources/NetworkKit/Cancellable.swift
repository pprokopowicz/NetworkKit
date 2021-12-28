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

internal final class CancellableTask: Cancellable {
    
    private let task: URLSessionTask
    
    init(task: URLSessionTask) {
        self.task = task
    }
    
    func cancel() {
        task.cancel()
    }
    
}
