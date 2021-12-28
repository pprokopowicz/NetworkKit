//
//  ContentViewModel.swift
//  NetworkKitExample
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import Foundation
import NetworkKit

@MainActor
final class ContentViewModel: ObservableObject {
    
    @Published var todos: [TodoModel] = []
    
    func fetch() {
        NetworkClient.shared.request(request: TodoService()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let todos):
                self.todos = todos
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func asyncFetch() async {
        let result = await NetworkClient.shared.request(request: TodoService())
        switch result {
        case .success(let todos):
            self.todos = todos
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
