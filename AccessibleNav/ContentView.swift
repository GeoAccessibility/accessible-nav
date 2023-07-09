//
//  ContentView.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-08.
//

import SwiftUI

struct ContentView: View {
    @State var isNavigating: Bool = false
    var body: some View {
        if !isNavigating {
            ZStack {
                Image("Map")
                    .resizable()
                    .scaledToFill()
                VStack {
                    Spacer(minLength: 0.5 * UIScreen.main.bounds.height)
                    LocationSelector()
                        .frame(width: UIScreen.main.bounds.width)
                        .shadow(radius: 10)
                }
            }
        } else {
            ZStack {
                Image("Map")
                    .resizable()
                    .scaledToFill()
                VStack {
                    CurrentDirection()
                        .frame(width: UIScreen.main.bounds.width)
                        .shadow(radius: 10)
                    Spacer(minLength: 0.7 * UIScreen.main.bounds.height)
                }
                VStack {
                    Spacer(minLength: 0.6 * UIScreen.main.bounds.height)
                    ETA()
                        .frame(width: UIScreen.main.bounds.width)
                        .shadow(radius: 10)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
