//
//  NetworkClient+CombineRequest.swift
//  
//
//  Created by Piotr Prokopowicz on 31/01/2022.
//

import Foundation
import Combine

extension NetworkClient {
    
    /// Request function is used to perform service request.
    ///
    /// - Parameter service: Service object that conforms to `NetworkService` protocol. Has every information that client needs to perform a service call.
    /// - Returns: `AnyPublisher` with either given services output type or an error. In case of Networking error it will be of type `NetworkError`.
    public func request<Request: NetworkRequest>(request r: Request) -> AnyPublisher<Request.Output, Error> {
        let subject = PassthroughSubject<Request.Output, Error>()
        request(request: r) { result in
            switch result {
            case .success(let output):
                subject.send(output)
                subject.send(completion: .finished)
            case .failure(let error):
                subject.send(completion: .failure(error))
            }
        }
        return subject.eraseToAnyPublisher()
    }
}
