//
//  LocationSelector.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-09.
//

import SwiftUI

struct LocationSelector: View {
    @EnvironmentObject var navParams: NavParams
    @EnvironmentObject var pager: Pager

    var body: some View {
        VStack {
            Spacer(minLength: 0.5 * UIScreen.main.bounds.height)
            ZStack {
                Rectangle()
                    .fill(.white)
                VStack {
                    HStack {
                        Text("Select Location")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Text("Your Location")
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                            Spacer()
                        }
                        TextField(
                            "Enter your location",
                            text: $navParams.locationInput
                        )
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 0.92 * UIScreen.main.bounds.width, height: 0.5)
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Text("Go to...")
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                            Spacer()
                        }
                        HStack {
                            Button(action: {
                                navParams.locationInput = "102 4th Ave E"
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 0.94, green: 0.945, blue: 0.95))
                                        .cornerRadius(5)
                                    HStack {
                                        Image("IconHome")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                        Text("Home")
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(width: .infinity, height: 40)
                                }
                            }
                            Button(action: {
                                navParams.locationInput = "1 Microsoft Way"
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 0.94, green: 0.945, blue: 0.95))
                                        .cornerRadius(5)
                                    HStack {
                                        Image("IconLocation")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                        Text("Office")
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(width: .infinity, height: 40)
                                }
                            }
                        }
                        HStack {
                            Button(action: {}) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 0.94, green: 0.945, blue: 0.95))
                                        .cornerRadius(5)
                                    HStack {
                                        Image("IconLocation")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                        Text("Other")
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(width: .infinity, height: 40)
                                }
                            }
                            Button(action: {
                                pager.page = Pages.filters
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 0.94, green: 0.945, blue: 0.95))
                                        .cornerRadius(5)
                                    HStack {
                                        Image("IconSearch")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        Text("Filters")
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Image("IconFilter")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                    .padding()
                                    .frame(width: .infinity, height: 40)
                                }
                            }
                        }
                        Button(action: {
                            pager.isNavigating = true
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(.blue)
                                    .cornerRadius(10)
                                    .frame(width: .infinity, height: 48)
                                HStack {
                                    Image("IconPaperPlane")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                    Text("Get Started")
                                        .fontWeight(.regular)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18))
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .padding()
            }
            .cornerRadius(20)
        }
    }
}

struct LocationSelector_Preview: PreviewProvider {
    @StateObject static var navParams: NavParams = NavParams()
    static var previews: some View {
        VStack {
            LocationSelector()
                .environmentObject(navParams)
        }
    }
}
