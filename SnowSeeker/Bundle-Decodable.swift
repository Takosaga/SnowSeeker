//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Gonzalo Gamez on 6/4/20.
//  Copyright © 2020 Gamez. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
         let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        return loaded
    }
}
