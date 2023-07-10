//
//  ContentView.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-08.
//

import SwiftUI

enum Pages {
    case splash, signin, newTrip, filters, navigation
}

class Pager: ObservableObject {
    @Published var page: Pages = Pages.splash
}

struct ContentView: View {
    @StateObject var pager: Pager = Pager()
    @StateObject var navParams: NavParams = NavParams()
    var body: some View {
        ZStack {
            switch pager.page {
            case Pages.splash:
                SplashView()
            case Pages.signin:
                SignInView()
            case Pages.newTrip:
                ZStack {
                    Image("Map")
                        .resizable()
                        .scaledToFill()
                    VStack {
                        Spacer(minLength: 0.5 * UIScreen.main.bounds.height)
                        LocationSelector()
                            .environmentObject(navParams)
                            .environmentObject(pager)
                            .frame(width: UIScreen.main.bounds.width)
                            .shadow(radius: 10)
                    }
                }
            case Pages.filters:
                FilterSelectorView()
                    .environmentObject(navParams)
                    .environmentObject(pager)
            case Pages.navigation:
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.pager.page = Pages.newTrip
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
