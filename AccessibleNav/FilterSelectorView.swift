//
//  FilterSelector.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-09.
//

import SwiftUI

struct FilterSelectorView: View {
    @State private var locationInput: String = ""
    @State private var optAvoidCrowds: Bool = true
    @State private var optAccessibleParking: Bool = true
    @State private var optBrailleSignage: Bool = false
    @State private var optElevation: Float = 18
    @State private var optCrimeReports: Bool = true
    @State private var optSocialMediaPosts: Bool = false
    @State private var optTrafficReports: Bool = true

    
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
                Toggle("Avoid crowds", isOn: $optAvoidCrowds)
                Toggle("Accessible parking", isOn: $optAccessibleParking)
                Toggle("Braille signage", isOn: $optBrailleSignage)
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
                    Slider(value: $optElevation, in: 0...40)
                    Text("\(String(optElevation)) km")
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
                    Toggle("", isOn: $optCrimeReports)
                        .frame(width: 57)
                    Spacer()
                    Text("Crime Reports")
                    Spacer()
                }
                HStack {
                    Toggle("", isOn: $optSocialMediaPosts)
                        .frame(width: 57)
                    Spacer()
                    Text("Social Media Posts")
                    Spacer()
                }
                HStack {
                    Toggle("", isOn: $optTrafficReports)
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
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .cornerRadius(10)
                        .frame(width: .infinity, height: 48)
                    Text("Get Started")
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct FilterSelectorView_Preview: PreviewProvider {
    static var previews: some View {
        FilterSelectorView()
    }
}
