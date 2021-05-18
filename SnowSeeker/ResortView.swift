//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Kristoffer Eriksson on 2021-05-18.
//

import SwiftUI

struct ResortView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites
    @State private var selectedFacility: Facility?
    let resort: Resort
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0){
                
                //Challenge 1
                ZStack(alignment: .bottomTrailing){
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    
                    
                    Text(resort.imageCredit)
                        .padding([.top, .horizontal])
                        .foregroundColor(.secondary)
                        
                }
                    
                Group{
                    
                    HStack{
                        if sizeClass == .compact {
                            Spacer()
                            VStack{
                                SkiDetailsView(resort: resort)
                            }
                            VStack{
                                ResortDetailsView(resort: resort)
                            }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                        
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
//                    Text(ListFormatter.localizedString(byJoining: resort.facilities))
//                        .padding(.vertical)
                    //resort.facilities.joined(separator: ", ")
                    HStack{
                        //Extension enables us to remove id: \.self
                        //And using a custom types enables us to remove extension
                        ForEach(resort.facilityTypes){ facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
                    if self.favorites.contains(self.resort) {
                        self.favorites.remove(self.resort)
                        //Challenge 2
                        self.favorites.save()
                    } else {
                        self.favorites.add(self.resort)
                        self.favorites.save()
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFacility){ facility in
            facility.alert
        }
    }
}

//extension String: Identifiable {
//    public var id: String {self}
//}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
