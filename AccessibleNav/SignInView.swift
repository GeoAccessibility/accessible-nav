//
//  SignInView.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-08.
//

import SwiftUI

struct SignInView: View {
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("NavigAbility")
                    .fontWeight(.heavy)
                    .foregroundColor(.blue)
                    .font(.system(size: 28))
                Text("Create or log into your account")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(EdgeInsets(top: 20, leading: 50, bottom: 0, trailing: 50))
                Text("Welcome to NavigAbilty, enter your details below to continue using the platform.")
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 1, leading: 50, bottom: 0, trailing: 50))
            }
            Spacer()
            VStack {
                HStack {
                    Text("Enter your phone")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.94, green: 0.945, blue: 0.95))
                        .cornerRadius(10)
                        .frame(width: 0.9 * UIScreen.main.bounds.width, height: 52)
                    HStack {
                        Image("IconCanada")
                        Image("IconDropDownTriangle")
                        TextField(
                            "Enter your phone",
                            text: $phoneNumber
                        )
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .frame(width: 0.65 * UIScreen.main.bounds.width, height: 52)
                    }
                }
            }
            Spacer()
            HStack {
                Rectangle()
                    .fill(.gray)
                    .frame(width: 150, height: 1)
                Text("OR")
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                Rectangle()
                    .fill(.gray)
                    .frame(width: 150, height: 1)
            }
            Spacer()
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.94, green: 0.945, blue: 0.95))
                        .cornerRadius(10)
                        .frame(width: 0.9 * UIScreen.main.bounds.width, height: 52)
                    HStack {
                        Image("IconGoogle")
                        Text("Continue with Google")
                    }
                }
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.94, green: 0.945, blue: 0.95))
                        .cornerRadius(10)
                        .frame(width: 0.9 * UIScreen.main.bounds.width, height: 52)
                    HStack {
                        Image("IconApple")
                        Text("Continue with Apple")
                    }
                }
            }
            Spacer()
        }
    }
}

struct SignInViewPreview: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
