//
//  CurrentDirection.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-09.
//

import SwiftUI

struct CurrentDirection: View {
    @State private var direction: String = "E 17th Ave"
    @State private var details: String = "toward Victor St"
    @State private var currentArrow: String = "⬆️"

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.gray)
                    .cornerRadius(20)
                HStack {
                    Text(currentArrow)
                        .font(.system(size: 40))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    VStack {
                        HStack {
                            Text(direction)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            HStack {
                                Text(details)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                                    .font(.system(size: 17))
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
            }
            HStack {
                NextDirection()
                Spacer()
            }
            Spacer(minLength: 0.7 * UIScreen.main.bounds.height)
        }
        .padding()
    }
}

struct NextDirection: View {
    @State private var nextArrow: String = "➡️"
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .frame(width: 100, height: 44)
                .cornerRadius(20)
            Text("Then \(nextArrow)")
                .fontWeight(.regular)
                .foregroundColor(.white)
                .font(.system(size: 17))
        }
    }
}

struct CurrentDirection_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            CurrentDirection()
        }
    }
}
