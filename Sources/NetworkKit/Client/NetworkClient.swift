//
//  Networking.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation

/// Struct that is responsible for creating api calls. It's built on top of `URLSession`.
public final class NetworkClient {
    
    /// Object used to build `URLRequest` from `NetworkRequest`.
    private let requestBuilder: URLRequestBuilderScheme
    /// Object used to build response from returned data.
    private let responseBuilder: ResponseBuilderScheme
    
    /// Initializes client with given parameters. Every parameter has default value.
    ///
    /// - Parameter requestBuilder: Object used to build `URLRequest` from `NetworkRequest`.
    /// - Parameter responseBuilder: Object used to build response from returned data.
    public init(
        requestBuilder: URLRequestBuilderScheme = URLRequestBuilder(),
        responseBuilder: ResponseBuilderScheme = ResponseBuilder()
    ) {
        self.requestBuilder = requestBuilder
        self.responseBuilder = responseBuilder
    }
    
}

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
        
        urlTask.resume()
        return urlTask
    }
    
}
