//
//  NavParams.swift
//  AccessibleNav
//
//  Created by rody on 2023-07-09.
//

import Foundation

struct Coordinate {
    var lat: Double
    var lon: Double
}

class NavParams: ObservableObject {
    @Published var locationInput: String = ""
    @Published var start: Coordinate = Coordinate(lat: 0, lon: 0)
    @Published var finish: Coordinate = Coordinate(lat: 0, lon: 0)
    @Published var optAvoidCrowds: Bool = true
    @Published var optAccessibleParking: Bool = true
    @Published var optBrailleSignage: Bool = false
    @Published var optElevation: Float = 18
    @Published var optCrimeReports: Bool = true
    @Published var optSocialMediaPosts: Bool = false
    @Published var optTrafficReports: Bool = true
    @Published var isPathDisplayed: Bool = false
}
