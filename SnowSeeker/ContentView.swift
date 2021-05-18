//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Kristoffer Eriksson on 2021-05-17.
//

import SwiftUI

enum sorting {
    case standard, alphabetical, country
}
enum filters {
    case country, size, price
}

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @ObservedObject var favorites = Favorites()
    
    
    //Challenge 3
    
    @State private var isShowingSettings = false
    
    @State private var sort: sorting = .standard
    @State private var filter: filters = .size
    @State private var filterSize = 3
    @State private var filterPrice = 3
    @State private var filterCountry = ""
    
    var sortedResorts: [Resort]{
        switch sort {
        case .alphabetical:
            return resorts.sorted{$0.name < $1.name}
        case .country:
            return resorts.sorted{$0.country < $1.country}
        default:
            return resorts
        }
    }
    var sortedAndFilteredResorts: [Resort]{
        switch filter {
        case .size:
            return sortedResorts.filter{ $0.size < filterSize }
        case .price:
            return sortedResorts.filter{$0.price <= filterPrice}
        default:
            return sortedResorts.filter{$0.country == filterCountry}
        }
    }
   
    var body: some View {
        
        NavigationView{
            List(sortedAndFilteredResorts){ resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1 )
                        )
                    
                    VStack(alignment: .leading){
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs)")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort){
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts ")
            .navigationBarItems(trailing: Button("Settings"){
                self.isShowingSettings = true
            })
            .sheet(isPresented: $isShowingSettings) {
                SettingsView(size: $filterSize, price: $filterPrice, country: $filterCountry, sort: $sort, filter: $filter)
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        
        //locks all phones to landscapeView
        //.phoneOnlyStackNavigationView()
    }
}

extension View{
    func phoneOnlyStackNavigationView() -> some View{
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
