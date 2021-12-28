//
//  Network+Plugin.swift
//  
//
//  Created by Piotr Prokopowicz on 20/12/2020.
//

extension NetworkClient {
    
    public func callPlugins<Service: NetworkService>(service: Service, event: NetworkPluginEvent) {
        plugins.forEach { $0.body(service: service, event: event, encoder: encoder, decoder: decoder) }
    }
    
}
