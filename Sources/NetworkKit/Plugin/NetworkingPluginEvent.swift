//
//  NetworkingPluginEvent.swift
//  
//
//  Created by Piotr Prokopowicz on 20/12/2020.
//

import Foundation

/// Events that happen during performing of requests.
public enum NetworkingPluginEvent {
    /// `Networking` client wasn't able to parse `NetworkingService` instance into `URLRequest`.
    case unableToParseRequest
    /// Data was successfully requested.
    case dataRequested
    /// An error occured during fetching of data.
    case responseError(data: Data, status: NetworkingStatus)
    /// Request was successfully performed.
    case success(data: Data, status: NetworkingStatus)
}
