//
//  NetworkPlugin.swift
//  
//
//  Created by Piotr Prokopowicz on 20/12/2020.
//

import Foundation

/// Protocol that allows to add extra functionality to `NetworkClient`.
public protocol NetworkPlugin {
    
    /// Function called by `Network` client on specific events with appropriate data.
    func body<Service: NetworkService>(service: Service, event: NetworkPluginEvent, encoder: JSONEncoder, decoder: JSONDecoder)
    
}
