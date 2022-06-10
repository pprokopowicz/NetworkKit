//
//  NetworkClient+AsyncRequest.swift
//  
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation

extension NetworkClient {
    
    /// Request function is used to perform service request.
    ///
    /// - Parameter service: Service object that conforms to `NetworkService` protocol. Has every information that client needs to perform a service call.
    /// - Returns: `Result` with either given services output type or an error. In case of Networking error it will be of type `NetworkError`.
    public func request<Request: NetworkRequest>(request: Request) async -> Result<Request.Output, Error> {
        await withCheckedContinuation { continuation in
            self.request(request: request) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
}
