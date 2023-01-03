//
//  BodyEncoder.swift
//  
//
//  Created by Piotr Prokopowicz on 11/06/2022.
//

import Foundation

public protocol BodyEncoderScheme {
    func encode(object: some Encodable) -> Result<Data, Error>
}

public struct BodyEncoder: BodyEncoderScheme {

    private let encoder: JSONEncoder

    public init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }

    public func encode(object: some Encodable) -> Result<Data, Error> {
        do {
            let data = try encoder.encode(object)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
