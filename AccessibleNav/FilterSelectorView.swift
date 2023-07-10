//
//  FilterSelector.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-09.
//

import SwiftUI

struct FilterSelectorView: View {
    @EnvironmentObject var navParams: NavParams
    @EnvironmentObject var pager: Pager
    
    var body: some View {
        VStack {
            Spacer()
            VStack { // Filters
                HStack {
                    Text("Select Filters")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .font(.system(size: 22))
                    Spacer()
                }
                Toggle("Avoid crowds", isOn: $navParams.optAvoidCrowds)
                Toggle("Accessible parking", isOn: $navParams.optAccessibleParking)
                Toggle("Braille signage", isOn: $navParams.optBrailleSignage)
            }
            Spacer()
            VStack { // Elevation
                HStack {
                    Text("Elevation")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    Spacer()
                }
                HStack {
                    Slider(value: $navParams.optElevation, in: 0...40)
                    Text("\(String(Int(navParams.optElevation))) km")
                }
            }
            Spacer()
            VStack { // Route Considerations
                HStack {
                    Text("Route Considerations")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    Spacer()
                }
                HStack {
                    Toggle("", isOn: $navParams.optCrimeReports)
                        .frame(width: 57)
                    Spacer()
                    Text("Crime Reports")
                    Spacer()
                }
                HStack {
                    Toggle("", isOn: $navParams.optSocialMediaPosts)
                        .frame(width: 57)
                    Spacer()
                    Text("Social Media Posts")
                    Spacer()
                }
                HStack {
                    Toggle("", isOn: $navParams.optTrafficReports)
                        .frame(width: 57)
                    Spacer()
                    Text("Traffic Reports")
                    Spacer()
                }
            }
            Spacer()
            HStack { // Save and Start
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.8, green: 0.9, blue: 1))
                        .cornerRadius(10)
                        .frame(width: .infinity, height: 48)
                    Text("Save Preset")
                        .fontWeight(.regular)
                        .foregroundColor(.blue)
                        .font(.system(size: 18))
                }
                Button(action: {
                    pager.page = Pages.newTrip
                }) {
                    ZStack {
                        Rectangle()
                            .fill(.blue)
                            .cornerRadius(10)
                            .frame(width: .infinity, height: 48)
                        Text("Done")
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct FilterSelectorView_Preview: PreviewProvider {
    @StateObject static var navParams: NavParams = NavParams()
    static var previews: some View {
        FilterSelectorView()
            .environmentObject(navParams)
    }
}
