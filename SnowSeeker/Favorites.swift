//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Gonzalo Gamez on 6/8/20.
//  Copyright © 2020 Gamez. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        //load save
        
        if let data = UserDefaults.standard.data(forKey: self.saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decoded
                return
            }
        }
        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let encode = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encode, forKey: self.saveKey)
        }
    }
}
