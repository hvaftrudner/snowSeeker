//
//  SettingsView.swift
//  SnowSeeker
//
//  Created by Kristoffer Eriksson on 2021-05-19.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentMode
    
    @Binding var size: Int
    @Binding var price: Int
    @Binding var country: String
    @Binding var sort: sorting
    @Binding var filter: filters
    
    var body: some View {
        NavigationView{
            VStack{
                
                Text("Sort list settings")
                    .font(.title)
                
                Spacer()
                
                HStack {
                    Text("Filter by: ")
                    
                    Button("alphabetical"){
                        self.sort = .alphabetical
                    }
                    Button("country"){
                        self.sort = .country
                    }
                    Button("standard"){
                        self.sort = .standard
                    }
                    
                }
                
                Section {
                    Text("Pick a size 1 to 5")
                    Picker("Size", selection: $size) {
                        ForEach(1...5, id: \.self){
                            Text("\($0)") //.tag(self.allSides[$0 + 1])
                            //.tag is needed or else it doesnt register
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
                Section {
                    Text("Pick a price 1 to 5")
                    Picker("Price", selection: $price) {
                        ForEach(1...5, id: \.self){
                            Text("\($0)") //.tag(self.allSides[$0 + 1])
                            //.tag is needed or else it doesnt register
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
        
                Section {
                    Text("Sort by countryname")
                    TextField("Enter a countryname", text: $country)
                }
                
                Text("Done")
                    .onTapGesture {
                        self.presentMode.wrappedValue.dismiss()
                    }
            }
            .navigationBarTitle("Settings")
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(size: 3, price: 3, country: "Sweden", sort: sorting.country, filter: filters.country)
//    }
//}
