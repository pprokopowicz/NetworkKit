//
//  NetworkMiddleware.swift
//  
//
//  Created by Piotr Prokopowicz on 29/12/2021.
//

import Foundation

public typealias RequestFunction<Output: Decodable> = (_ urlRequest: URLRequest, _ completion: @escaping (Result<Output, Error>, Data?, URLResponse?) -> Void) -> Cancellable?

public protocol NetworkMiddleware {
    func body<Output: Decodable>() -> (@escaping RequestFunction<Output>) -> RequestFunction<Output>
}
