//
//  NavParams.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-09.
//

import Foundation

class NavParams: ObservableObject {
    @Published var locationInput: String = ""
    @Published var optAvoidCrowds: Bool = true
    @Published var optAccessibleParking: Bool = true
    @Published var optBrailleSignage: Bool = false
    @Published var optElevation: Float = 18
    @Published var optCrimeReports: Bool = true
    @Published var optSocialMediaPosts: Bool = false
    @Published var optTrafficReports: Bool = true
}
