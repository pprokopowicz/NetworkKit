//
//  NetworkClient+Request.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation
import Combine

extension NetworkClient {
    
    /// Request function is used to perform service request.
    ///
    /// - Parameter service: Service object that conforms to `NetworkService` protocol. Has every information that client needs to perform a service call.
    /// - Parameter completion: Completion handler with `Result` with either given services output type or an error. In case of Networking error it will be of type `NetworkError`.
    @discardableResult
    public func request<Service: NetworkService>(service: Service, completion: @escaping (Result<Service.Output, Error>) -> Void) -> Cancellable? {
        guard let urlRequest = URLRequest(service: service, encoder: encoder, timeout: timeout) else {
            
            DispatchQueue.main.async {
                completion(.failure(NetworkError<NetworkEmpty>(status: .unableToParseRequest, response: nil)))
            }
            return nil
        }
        
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let data = data ?? Data()
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                
                return
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse else {
                let errorResponse = try? decoder.decode(Service.ErrorResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.failure(NetworkError(status: .unknown, response: errorResponse)))
                }
                
                return
            }
            
            guard 200...299 ~= httpURLResponse.statusCode else {
                let errorResponse = try? decoder.decode(Service.ErrorResponse.self, from: data)
                let status = NetworkResponseStatus(rawValue: httpURLResponse.statusCode) ?? .unknown
                
                DispatchQueue.main.async {
                    completion(.failure(NetworkError(status: status, response: errorResponse)))
                }
                
                return
            }
            
            do {
                let model = try decoder.decode(Service.Output.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            } catch(let error) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        let task = Task(task: urlTask)
        urlTask.resume()
        return task
    }
    
}
