//
//  ContentView.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-08.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                NavigationLink(destination: ARContentView()) {
                    Text("Do Something")
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
