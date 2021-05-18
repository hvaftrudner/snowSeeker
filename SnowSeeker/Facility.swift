//
//  Facility.swift
//  SnowSeeker
//
//  Created by Kristoffer Eriksson on 2021-05-18.
//

import Foundation
import SwiftUI

struct Facility: Identifiable {
    
    let id = UUID()
    var name: String
    
    var icon:  some View {
        let icons = [
            "Accommodation" : "house",
            "Beginners": "1.circle",
            "Cross-country": "map",
            "Eco-friendly": "leaf.arrow.circlepath",
            "Family": "person.3"
        ]
        
        if let iconName = icons[name] {
            let image = Image(systemName: iconName)
                .accessibility(label: Text(name))
                .foregroundColor(.secondary)
            
            return image
        } else {
            fatalError("Unknown facility type: \(name)")
        }
    }
    
    var alert: Alert {
        let messages = [
            "Accommodation": "This resort has popular onsite accommodation",
            "Beginner": "This resort has a lot of ski schools",
            "Cross-country": "This resort has many cross-country tracks",
            "Eco-friendy": "This resort has won an award or environmental friendlyness",
            "Family": "This resort is very family friendly"
        ]
        
        if let message = messages[name]{
            return Alert(title: Text(name), message: Text(message))
        } else {
            fatalError("Unknown facility type \(name)")
        }
    }
}
