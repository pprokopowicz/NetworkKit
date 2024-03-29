//
//  Session.swift
//  
//
//  Created by Piotr Prokopowicz on 10/06/2022.
//

import Foundation

/// Protocol used to provide a "backend" abstraction to `NetworkClient`
public protocol Session {
    func task(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTask
}

extension URLSession: Session {
    public func task(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTask {
        dataTask(with: urlRequest, completionHandler: completionHandler)
    }
}
