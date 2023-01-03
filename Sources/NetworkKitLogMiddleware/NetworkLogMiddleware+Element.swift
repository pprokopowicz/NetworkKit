//
//  NetworkLogMiddleware+Element.swift
//  
//
//  Created by Piotr Prokopowicz on 03/01/2023.
//

import Foundation

extension NetworkLogMiddleware {
    /// Enum that gives `NetworkLoggerMiddleware` information on what user wants to log.
    public enum Element {
        /// Responsible for logging date of an event. Example "2020-10-02 17:44:37 +0000".
        case date
        /// Emoji character used as icon.
        case icon
        /// Responsible for logging name of this library. Can be used to filter logs in the console.
        case libraryName
        /// Emoji character used distinguish failure from success.
        case emoji
        /// HTTP status code of a given request.
        case statusCode
        /// HTTP method used for a given service.
        case httpMethod
        /// URL created from a given service.
        case url
        /// Headers used for the request.
        case headers
        /// Data associated with a request or response.
        case data
    }
}
