//
//  ETA.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-09.
//

import SwiftUI

struct ETA: View {
    @State private var arrivalBy: String = "8:32"
    @State private var time: String = "16"
    @State private var distance: String = "2.5"

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .cornerRadius(20)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Text(arrivalBy)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                            Text("Arrival")
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }
                        Spacer()
                        VStack {
                            Text(time)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                            Text("min")
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }
                        Spacer()
                        VStack {
                            Text(distance)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                            Text("km")
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }
                        Spacer()
                    }
                    Spacer(minLength: 30)
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 0.3, green: 0.3, blue: 0.3))
                            .cornerRadius(10)
                            .frame(width: .infinity, height: 48)
                        HStack {
                            Image("IconPaperPlane")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.blue)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Get Started")
                                .fontWeight(.regular)
                                .foregroundColor(.blue)
                                .font(.system(size: 18))
                        }
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .padding()
    }
}

struct ETA_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Rectangle()
                .frame(
                    width: .infinity,
                    height: 0.7 * UIScreen.main.bounds.height
                )
            ETA()
            Rectangle()
                .frame(
                    width: .infinity,
                    height: 0.05 * UIScreen.main.bounds.height
                )
        }
    }
}
