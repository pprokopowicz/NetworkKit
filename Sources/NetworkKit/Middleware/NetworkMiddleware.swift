//
//  NetworkMiddleware.swift
//  
//
//  Created by Piotr Prokopowicz on 29/12/2021.
//

import Foundation

public typealias RequestFunction<Output: Decodable> = (_ urlRequest: URLRequest, _ completion: @escaping (Result<Output, Error>, Data?, URLResponse?) -> Void) -> Cancellable?

/// Protocol that enables users to add extra functionalities to `NetworkClient` class.
public protocol NetworkMiddleware {
    /// Function used to modify request/response/add new functionalities to `NetworkClient`.
    func body<Output: Decodable>() -> (@escaping RequestFunction<Output>) -> RequestFunction<Output>
}
