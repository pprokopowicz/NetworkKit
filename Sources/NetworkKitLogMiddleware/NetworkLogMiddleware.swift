//
//  NetworkLogMiddleware.swift
//  
//
//  Created by Piotr Prokopowicz on 03/01/2023.
//

import Foundation
import NetworkKit

/// Middleware responsible for logging requests and responses to the console.
/// To modify what is logged check `elements` parameter of `init`.
public struct NetworkLogMiddleware: NetworkKit.Middleware {
    
    private let logElements: [Element]
    
    /// Initializes the middleware with information on what the user wants to log to console.
    ///
    /// - Parameter elements: Array of `Element` enum. Based on values in this array information is being logged. Order and duplication of values does matter.
    public init(elements: [Element] = [.date, .icon, .libraryName, .emoji, .statusCode, .httpMethod, .url, .headers, .data]) {
        logElements = elements
    }

    public func prepare<Request: NetworkRequest>(request: Request, urlRequest: URLRequest) -> URLRequest {
#if DEBUG
        print(newRequestLog(urlRequest: urlRequest))
#endif
        
        return urlRequest
    }

    public func process<Request: NetworkRequest>(
        client: NetworkClient,
        request: Request,
        urlRequest: URLRequest,
        result: Result<Request.Output, Error>,
        data: Data?,
        response: URLResponse?
    ) async -> Result<Request.Output, Error> {
#if DEBUG
        switch result {
        case .success:
            print(successLog(urlRequest: urlRequest, responseBody: data, response: response))
        case .failure:
            print(failureLog(urlRequest: urlRequest, responseBody: data, response: response))
        }
#endif
        
        return result
    }
    
}

extension NetworkLogMiddleware {
    
    private enum Constant {
        static let libraryName: String = "NetworkKit"
        static let successEmoji: String = "🟢"
        static let failureEmoji: String = "🔴"
        static let icon: String = "🌎"
    }
    
    private func statusCode(from urlResponse: URLResponse?) -> String {
        let httpResponse = urlResponse as? HTTPURLResponse
        return "\(httpResponse?.statusCode ?? -1)"
    }
    
    private func body(from data: Data) -> String {
        String(data: data, encoding: .utf8) ?? .emptyJSON
    }
    
    private func newRequestLog(urlRequest: URLRequest) -> String {
        let message: String = logElements.compactMap {
            switch $0 {
            case .date:
                return "\(Date())"
            case .icon:
                return Constant.icon
            case .libraryName:
                return Constant.libraryName
            case .emoji:
                return nil
            case .statusCode:
                return nil
            case .httpMethod:
                return urlRequest.httpMethod
            case .url:
                return urlRequest.url?.absoluteString ?? ""
            case .headers:
                return "\nHEADERS: \(urlRequest.allHTTPHeaderFields ?? [:])"
            case .data:
                return urlRequest.httpBody.map { "\nBODY: \(body(from: $0))" }
            }
        }.joined(separator: " - ")
        return message
    }
    
    private func successLog(urlRequest: URLRequest, responseBody: Data?, response: URLResponse?) -> String {
        let message: String = logElements.compactMap {
            switch $0 {
            case .date:
                return "\(Date())"
            case .icon:
                return Constant.icon
            case .libraryName:
                return Constant.libraryName
            case .emoji:
                return Constant.successEmoji
            case .statusCode:
                return statusCode(from: response)
            case .httpMethod:
                return urlRequest.httpMethod
            case .url:
                return urlRequest.url?.absoluteString ?? ""
            case .headers:
                return "\nHEADERS: \(urlRequest.allHTTPHeaderFields ?? [:])"
            case .data:
                return responseBody.map { "\nBODY: \(body(from: $0))" }
            }
        }.joined(separator: " - ")
        return message
    }
    
    private func failureLog(urlRequest: URLRequest, responseBody: Data?, response: URLResponse?) -> String {
        let message: String = logElements.compactMap {
            switch $0 {
            case .date:
                return "\(Date())"
            case .icon:
                return Constant.icon
            case .libraryName:
                return Constant.libraryName
            case .emoji:
                return Constant.failureEmoji
            case .statusCode:
                return statusCode(from: response)
            case .httpMethod:
                return urlRequest.httpMethod
            case .url:
                return urlRequest.url?.absoluteString ?? ""
            case .headers:
                return "\nHEADERS: \(urlRequest.allHTTPHeaderFields ?? [:])"
            case .data:
                return responseBody.map { "\nBODY: \(body(from: $0))" }
            }
        }.joined(separator: " - ")
        return message
    }
    
}

fileprivate extension String {
    static var emptyJSON: String { "{}" }
}
