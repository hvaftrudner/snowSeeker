//
//  resort.swift
//  SnowSeeker
//
//  Created by Kristoffer Eriksson on 2021-05-18.
//

import Foundation

struct Resort: Codable, Identifiable, Comparable {
    
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        return lhs > rhs
    }
    
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
