//
//  Networking.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation

/// Class that is responsible for creating api calls. By default it's built on top of `URLSession`, but you can provide your own `Session` implementation.
public final class NetworkClient {
    
    private let requestBuilder: URLRequestBuilderScheme
    private let responseBuilder: ResponseBuilderScheme
    private let session: Session
    
    /// Initializes client with given parameters. Every parameter has default value.
    ///
    /// - Parameter requestBuilder: Object used to build `URLRequest` from `NetworkRequest`.
    /// - Parameter responseBuilder: Object used to build response from returned data.
    /// - Parameter session: Object used as "backend" for making API calls. By default `URLSession` is used, but you can provide your own implementation.
    public init(
        requestBuilder: URLRequestBuilderScheme = URLRequestBuilder(),
        responseBuilder: ResponseBuilderScheme = ResponseBuilder(),
        session: Session = URLSession.shared
    ) {
        self.requestBuilder = requestBuilder
        self.responseBuilder = responseBuilder
        self.session = session
    }
    
}

extension NetworkClient {
    
    /// Request function is used to perform service request.
    ///
    /// - Parameter service: Service object that conforms to `NetworkService` protocol. Has every information that client needs to perform a service call.
    /// - Parameter completion: Completion handler with `Result` with either given services output type or an error. In case of Networking error it will be of type `NetworkError`.
    /// - Returns: `Cancellable` object used to cancel request.
    @discardableResult
    public func request<Request: NetworkRequest>(request: Request, completion: @escaping (Result<Request.Output, Error>) -> Void) -> DataTask? {
        guard let urlRequest = requestBuilder.request(from: request) else {
            completion(.failure(NetworkError<Request.ErrorResponse>(status: .unableToParseRequest, response: nil)))
            return nil
        }
        
        let dataTask = session.task(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                completion(.failure(NetworkError<NetworkEmpty>(status: .unknown, response: nil)))
                return
            }
            completion(self.responseBuilder.response(Request.Output.self, errorType: Request.ErrorResponse.self, data: data, response: response, error: error))
        }
        
        dataTask.resume()
        return dataTask
    }
    
}
