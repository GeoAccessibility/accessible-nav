//
//  SplashView.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-08.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashViewPreview: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
