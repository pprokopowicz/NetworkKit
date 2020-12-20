//
//  NetworkingPluginEvent.swift
//  
//
//  Created by Piotr Prokopowicz on 20/12/2020.
//

import Foundation

public enum NetworkingPluginEvent {
    case unableToParseRequest
    case dataRequested
    case responseError(data: Data, status: NetworkingStatus)
    case success(data: Data, status: NetworkingStatus)
}
