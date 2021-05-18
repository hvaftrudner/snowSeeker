//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Kristoffer Eriksson on 2021-05-18.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init(){
        //load our saved data
        
        self.resorts = []
        
        //Challenge 2
        if self.resorts.isEmpty {
            self.resorts = load(name: saveKey)
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort){
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort){
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    //challenge 2
    func save(){
        //write out our data
        if let encoded = try? JSONEncoder().encode(resorts){
            //saving using userDefaults
            //UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        
            //saving writing to disk
            do {
                let filename = getDocumentsDirectory().appendingPathComponent(saveKey)
                    //let data = try JSONEncoder().encode(self.people)
                try encoded.write(to: filename, options: [.atomicWrite, .completeFileProtection])
                    print("saved data")
                } catch {
                    print("Unable to save data")
                }
                   
            }
    }
    
    func load(name: String) -> Set<String> {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        if let data = try? Data(contentsOf: url) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
