//
//  NetworkError.swift
//  
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

/// Struct containing information about an error returned from a network request.
public struct NetworkError<Response: Decodable>: Error {
    
    /// Value representing http status code in a form of an enum case.
    public let status: NetworkResponseStatus
    /// Error data returned decoded into an object.
    public let response: Response?
    /// Value representing http status code in a form of an `Int`.
    public var code: Int { status.rawValue }
    
    /// Initializes error object with given parameters.
    ///
    /// - Parameter code: Value representing http status code in a form of an `Int`.
    /// - Parameter response: Error data returned decoded into an object.
    public init(code: Int, response: Response?) {
        status = NetworkResponseStatus(rawValue: code) ?? .unknown
        self.response = response
    }
    
    /// Initializes error object with given parameters.
    /// 
    /// - Parameter status: Value representing http status code in a form of an enum case.
    /// - Parameter response: Error data returned decoded into an object.
    public init(status: NetworkResponseStatus, response: Response?) {
        self.status = status
        self.response = response
    }
    
}

/// Enum type representing http status codes
public enum NetworkResponseStatus: Int {
    
    case unknown                        = -1
    case unableToParseRequest           = -2
    case unableToParseResponse          = -3
    
    // 1xx Informational
    case continueError                  = 100
    case switchingProtocols             = 101
    case processing                     = 102
    
    // 2xx Success
    case ok                             = 200
    case created                        = 201
    case accepted                       = 202
    case nonAuthoritativeInformation    = 203
    case noContent                      = 204
    case resetContent                   = 205
    case partialContent                 = 206
    case multiStatus                    = 207
    case alreadyReported                = 208
    case IMUsed                         = 226
    
    // 3xx Redirection
    case multipleChoices                = 300
    case movedPermanently               = 301
    case found                          = 302
    case seeOther                       = 303
    case notModified                    = 304
    case useProxy                       = 305
    case switchProxy                    = 306
    case temporaryRedirect              = 307
    case permenantRedirect              = 308
    
    // 4xx Client Error
    case badRequest                     = 400
    case unauthorized                   = 401
    case paymentRequired                = 402
    case forbidden                      = 403
    case notFound                       = 404
    case methodNotAllowed               = 405
    case notAcceptable                  = 406
    case proxyAuthenticationRequired    = 407
    case requestTimeout                 = 408
    case conflict                       = 409
    case gone                           = 410
    case lengthRequired                 = 411
    case preconditionFailed             = 412
    case payloadTooLarge                = 413
    case uriTooLong                     = 414
    case unsupportedMediaType           = 415
    case rangeNotSatisfiable            = 416
    case expectationFailed              = 417
    case teapot                         = 418
    case misdirectedRequest             = 421
    case unprocessableEntity            = 422
    case locked                         = 423
    case failedDependency               = 424
    case upgradeRequired                = 426
    case preconditionRequired           = 428
    case tooManyRequests                = 429
    case requestHeaderFieldsTooLarge    = 431
    case unavailableForLegalReasons     = 451
    
    // 4xx nginx
    case noResponse                     = 444
    case sslCertificateError            = 495
    case sslCertificateRequired         = 496
    case httpRequestSentToHTTPSPort     = 497
    case clientClosedRequest            = 499
    
    // 5xx Server Error
    case internalServerError            = 500
    case notImplemented                 = 501
    case badGateway                     = 502
    case serviceUnavailable             = 503
    case gatewayTimeout                 = 504
    case httpVersionNotSupported        = 505
    case variantAlsoNegotiates          = 506
    case insufficientStorage            = 507
    case loopDetected                   = 508
    case notExtended                    = 510
    case networkAuthenticationRequired  = 511
    
}
