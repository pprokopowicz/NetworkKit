//
//  NetworkingPlugin.swift
//  
//
//  Created by Piotr Prokopowicz on 20/12/2020.
//

public protocol NetworkingPlugin {
    
    func body<Service: NetworkingService>(service: Service, event: NetworkingPluginEvent)
    
}
