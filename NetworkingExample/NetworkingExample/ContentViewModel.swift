//
//  ContentViewModel.swift
//  NetworkingExample
//
//  Created by Piotr Prokopowicz on 08/12/2020.
//

import Foundation
import Networking
import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var todos: [TodoModel] = []
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetch() {
        NetworkingProvider.shared
            .request(service: TodoService())
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .assign(to: \.todos, on: self)
            .store(in: &cancellables)
    }
    
}
