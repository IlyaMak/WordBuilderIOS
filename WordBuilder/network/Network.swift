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
    
    //Endpoint, application(need token), parameters(Map), callback, onError(maybe call in catch or else)?
    static func postApplication(application: Application, onSuccess: @escaping (String) -> ()) {
        let parameters: [String: Any] = ["name": application.name]
        let url = URL(string: Endpoints.applications)!
        
        // create the session object
        let session = URLSession.shared
        
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
          // convert parameters to Data and assign dictionary to httpBody of request
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
          print(error.localizedDescription)
        }
        
        // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
          
          if let error = error {
            print("Post Request Error: \(error.localizedDescription)")
            return
          }
          
          // ensure there is valid response code returned from this HTTP response
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
          else {
            print("Invalid Response received from the server")
            return
          }
          
          // ensure there is data returned
          guard let responseData = data else {
            print("nil Data received from the server")
            return
          }
          
          do {
            // create json object from data or use JSONDecoder to convert to Model stuct
            if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                onSuccess(jsonResponse["token"] as! String)
              print(jsonResponse)
              // handle json response
            } else {
              print("data maybe corrupted or in wrong format")
              throw URLError(.badServerResponse)
            }
          } catch let error {
            print(error.localizedDescription)
          }
        }
        // perform the task
        task.resume()
    }
}
