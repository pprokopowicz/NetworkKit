//
//  ContentView.swift
//  NetworkKitExample
//
//  Created by Piotr Prokopowicz on 28/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.todos, id: \.id) { todo in
                Text(todo.title)
            }
            
            Button("Fetch todos") {
                viewModel.fetch()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
