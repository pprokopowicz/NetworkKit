//
//  NetworkingPlugin.swift
//  
//
//  Created by Piotr Prokopowicz on 20/12/2020.
//

import Foundation

/// Protocol that allows to add extra functionality to `Networking` client.
public protocol NetworkingPlugin {
    
    /// Function called by `Networking` client on specific events with appropriate data.
    func body<Service: NetworkingService>(service: Service, event: NetworkingPluginEvent, encoder: JSONEncoder, decoder: JSONDecoder)
    
}
