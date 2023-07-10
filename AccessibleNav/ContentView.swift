//
//  ContentView.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-08.
//

import SwiftUI
import MapKit

enum Pages {
    case splash, signin, map, filters
}

class Pager: ObservableObject {
    @Published var page: Pages = Pages.splash
    @Published var isNavigating: Bool = false
}


struct ContentView: View {
    @StateObject var pager: Pager = Pager()
    @StateObject var navParams: NavParams = NavParams()
    @State var locationManager: CLLocationManager = CLLocationManager()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.627499, longitude: -122.318783), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var body: some View {
        ZStack {
            switch pager.page {
            case Pages.splash:
                SplashView()
            case Pages.signin:
                SignInView()
            case Pages.map:
                ZStack {
                    Map(
                        coordinateRegion: $region,
                        interactionModes: [.all],
                        showsUserLocation: true,
                        userTrackingMode: .constant(.follow)
                    )
                    if !self.pager.isNavigating {LocationSelector()
                            .environmentObject(navParams)
                            .environmentObject(pager)
                            .frame(width: UIScreen.main.bounds.width)
                            .shadow(radius: 10)
                    } else {
                        ZStack {
                            CurrentDirection()
                                .frame(width: UIScreen.main.bounds.width)
                                .shadow(radius: 10)
                            ETA()
                                .environmentObject(pager)
                                .frame(width: UIScreen.main.bounds.width)
                                .shadow(radius: 10)
                        }
                    }
                    if navParams.isPathDisplayed {
                        HStack {
                            Spacer(minLength: 200)
                            VStack {
                                Spacer()
                                Image("TripPathThick")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                Spacer(minLength: 398)
                            }
                            Spacer()
                        }
                    }
                }
            case Pages.filters:
                FilterSelectorView()
                    .environmentObject(navParams)
                    .environmentObject(pager)
            }
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.pager.page = Pages.map
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
