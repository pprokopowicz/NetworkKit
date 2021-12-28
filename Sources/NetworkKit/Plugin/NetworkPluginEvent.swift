//
//  NetworkPluginEvent.swift
//  
//
//  Created by Piotr Prokopowicz on 20/12/2020.
//

import Foundation

/// Events that happen during performing of requests.
public enum NetworkPluginEvent {
    /// `NetworkClient` wasn't able to parse `NetworkService` instance into `URLRequest`.
    case unableToParseRequest
    /// Data was successfully requested.
    case dataRequested
    /// An error occured during fetching of data.
    case responseError(data: Data, status: NetworkResponseStatus)
    /// Request was successfully performed.
    case success(data: Data, status: NetworkResponseStatus)
}
