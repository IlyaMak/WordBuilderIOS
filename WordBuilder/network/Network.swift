//
//  Network.swift
//  WordBuilder
//
//  Created by ilya on 9.10.22.
//

import SwiftUI

class Network {
    @Published var leaders: [Leader] = []
//    @Published var levels: [Level] = []
    
//    func getLevels() {
//        guard let url = URL(string: Endpoints.getLevels) else { fatalError("Missing URL") }
//
//        let urlRequest = URLRequest(url: url)
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        let decodedLevels = try JSONDecoder().decode([Level].self, from: data)
//                        self.levels = decodedLevels
//                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
//            }
//        }
//
//        dataTask.resume()
//    }
    
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
    
    func getLeaders() {
        guard let url = URL(string: Endpoints.getLeaders) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedLeaders = try JSONDecoder().decode([Leader].self, from: data)
                        self.leaders = decodedLeaders
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
}
