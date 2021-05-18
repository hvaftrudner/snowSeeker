//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Kristoffer Eriksson on 2021-05-18.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Welcome to snowseeker!")
                .font(.largeTitle)
            
            Text("Please choose an resort from the left-hand menu, swipe from the left edge to show it")
                .foregroundColor(.secondary )
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
