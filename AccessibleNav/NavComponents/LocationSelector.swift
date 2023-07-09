//
//  LocationSelector.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-09.
//

import SwiftUI

struct LocationSelector: View {
    @State private var locationInput: String = ""

    var body: some View {
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
                        text: $locationInput
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
                                Spacer()
                            }
                            .padding()
                            .frame(width: .infinity, height: 40)
                        }
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
                                Spacer()
                            }
                            .padding()
                            .frame(width: .infinity, height: 40)
                        }
                    }
                    HStack {
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
                                Spacer()
                            }
                            .padding()
                            .frame(width: .infinity, height: 40)
                        }
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
                    Spacer()
                }
            }
            .padding()
        }
        .cornerRadius(20)
    }
}

struct LocationSelector_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Rectangle()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: 0.5 * UIScreen.main.bounds.height
                )
            LocationSelector()
        }
    }
}
