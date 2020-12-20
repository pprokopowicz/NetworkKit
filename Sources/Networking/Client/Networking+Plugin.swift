//
//  Networking+Plugin.swift
//  
//
//  Created by Piotr Prokopowicz on 20/12/2020.
//

extension Networking {
    
    func callPlugins<Service: NetworkingService>(service: Service, event: NetworkingPluginEvent) {
        plugins.forEach { $0.body(service: service, event: event) }
    }
    
}
