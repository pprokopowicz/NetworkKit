//
//  NetworkClient+Request.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation

extension NetworkClient {
    
    /// Request function is used to perform service request.
    ///
    /// - Parameter service: Service object that conforms to `NetworkService` protocol. Has every information that client needs to perform a service call.
    /// - Parameter completion: Completion handler with `Result` with either given services output type or an error. In case of Networking error it will be of type `NetworkError`.
    /// - Returns: `Cancellable` object used to cancel request.
    @discardableResult
    public func request<Request: NetworkRequest>(request: Request, completion: @escaping (Result<Request.Output, Error>) -> Void) -> Cancellable? {
        guard let urlRequest = requestBuilder.request(from: request) else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError<NetworkEmpty>(status: .unableToParseRequest, response: nil)))
            }
            return nil
        }
        
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                completion(.failure(NetworkError<Request.ErrorResponse>(status: .unknown, response: nil)))
                return
            }
            
            DispatchQueue.main.async {
                completion(self.responseBuilder.response(from: request, data: data, response: response, error: error))
            }
        }
        
        let task = CancellableTask(task: urlTask)
        urlTask.resume()
        return task
    }
    
}
