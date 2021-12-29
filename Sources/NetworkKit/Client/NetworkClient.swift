//
//  Networking.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation

/// Class that is responsible for creating api calls. It's built on top of `URLSession`.
public final class NetworkClient {
    
    private let requestBuilder: URLRequestBuilderScheme
    private let responseBuilder: ResponseBuilderScheme
    private let middlewares: [NetworkMiddleware]
    
    /// Initializes client with given parameters. Every parameter has default value.
    ///
    /// - Parameter requestBuilder: Object used to build `URLRequest` from `NetworkRequest`.
    /// - Parameter responseBuilder: Object used to build response from returned data.
    public init(middlewares: [NetworkMiddleware] = []) {
        self.requestBuilder = URLRequestBuilder()
        self.responseBuilder = ResponseBuilder()
        self.middlewares = middlewares
    }
    
}

extension NetworkClient {
    
    private func defaultRequest<Output: Decodable, ErrorOutput: Decodable>(_ errorType: ErrorOutput.Type, urlRequest: URLRequest, completion: @escaping (Result<Output, Error>, Data?, URLResponse?) -> Void) -> Cancellable? {
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                completion(
                    .failure(NetworkError<NetworkEmpty>(status: .unknown, response: nil)),
                    nil,
                    nil
                )
                return
            }
            completion(
                self.responseBuilder.response(Output.self, errorType: errorType, data: data, response: response, error: error),
                data,
                response
            )
        }
        
        urlTask.resume()
        return urlTask
    }
    
    /// Request function is used to perform service request.
    ///
    /// - Parameter service: Service object that conforms to `NetworkService` protocol. Has every information that client needs to perform a service call.
    /// - Parameter completion: Completion handler with `Result` with either given services output type or an error. In case of Networking error it will be of type `NetworkError`.
    /// - Returns: `Cancellable` object used to cancel request.
    @discardableResult
    public func request<Request: NetworkRequest>(request: Request, completion: @escaping (Result<Request.Output, Error>) -> Void) -> Cancellable? {
        guard let urlRequest = requestBuilder.request(from: request) else {
            completion(.failure(NetworkError<Request.ErrorResponse>(status: .unableToParseRequest, response: nil)))
            return nil
        }
        
        let requestFunction: RequestFunction<Request.Output> = middlewares
            .reversed()
            .reduce(
                { self.defaultRequest(Request.ErrorResponse.self, urlRequest: $0, completion: $1) },
                { requestFunction, middleware in
                    return middleware.body()(requestFunction)
                }
            )
        let mappedCompletion: (Result<Request.Output, Error>, Data?, URLResponse?) -> Void = { result, _, _ in
            completion(result)
        }
        
        return requestFunction(urlRequest, mappedCompletion)
    }
    
}
