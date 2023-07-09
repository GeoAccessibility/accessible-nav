//
//  SplashView.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-08.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            ZStack {
                Image("BgSplash")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: 1.15 * UIScreen.main.bounds.width,
                        height: 1.15 * UIScreen.main.bounds.height
                    )
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                VStack {
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Text("NavigAbility Solutions")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    Text("Making navigation accessible")
                        .italic()
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    
                }
            }
        }
    }
}

struct SplashView_Preview: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
