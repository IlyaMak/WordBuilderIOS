//
//  Network.swift
//  WordBuilder
//
//  Created by ilya on 9.10.22.
//

import SwiftUI

class Network {
    func getLevels(completions: @escaping ([Level]) -> ()) {
        guard let url = URL(string: Endpoints.getLevels) else { fatalError("Missing URL") }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let decodedLevels = try! JSONDecoder().decode([Level].self, from: data!)
            
            DispatchQueue.main.async {
                completions(decodedLevels)
            }
        }
        .resume()
    }
    
    func getLeaders(completions: @escaping ([Leader]) -> ()) {
        guard let url = URL(string: Endpoints.getLeaders) else { fatalError("Missing URL") }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let decodedLeaders = try! JSONDecoder().decode([Leader].self, from: data!)
            
            DispatchQueue.main.async {
                completions(decodedLeaders)
            }
        }
        .resume()
    }
}
