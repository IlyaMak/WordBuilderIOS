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
    
    func getLeaders(application: Application, onSuccess: @escaping ([Leader]) -> ()) {
        guard let url = URL(string: Endpoints.getLeaders) else { fatalError("Missing URL") }
        
        var request = URLRequest(url: url)
        request.addValue(application.token, forHTTPHeaderField: "X-Application-Token")
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            let decodedLeaders = try! JSONDecoder().decode([Leader].self, from: data!)
            
            DispatchQueue.main.async {
                onSuccess(decodedLeaders)
            }
        }
        .resume()
    }
    
    static func createPostRequest(endpoint: String, application: Application, parameters: Any,  onSuccess: @escaping (Any?) -> (), onError: @escaping () -> ()) {
        makeRequest(httpMethod: "POST", endpoint: endpoint, application: application, onSuccess: onSuccess, onError: onError, parameters: parameters)
    }
    
    static func createGetRequest(endpoint: String, application: Application, onSuccess: @escaping (Any?) -> (), onError: @escaping () -> ()) {
        makeRequest(httpMethod: "GET", endpoint: endpoint, application: application, onSuccess: onSuccess, onError: onError)
    }
    
    static func makeRequest(httpMethod: String, endpoint: String, application: Application,  onSuccess: @escaping (Any?) -> (), onError: @escaping () -> (), parameters: Any? = nil) {
        guard let url = URL(string: endpoint) else {
            print("err url")
            return onError()
        }
        
        // create the session object
        let session = URLSession.shared
        
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(application.token, forHTTPHeaderField: "X-Application-Token")
        
        if parameters != nil {
            do {
              // convert parameters to Data and assign dictionary to httpBody of request
              request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
            } catch let error {
                print("Serialization: " + error.localizedDescription)
                onError()
            }
        }
        
        // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
          
          if let error = error {
            print("Post Request Error: \(error.localizedDescription)")
            onError()
            return
          }
          
          // ensure there is valid response code returned from this HTTP response
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
          else {
            print("Invalid Response received from the server")
            onError()
            return
          }
          
          // ensure there is data returned
            guard let responseData = data else {
            print("nil Data received from the server")
            onError()
            return
          }
            
            if (responseData.isEmpty) {
                onSuccess(nil)
                return
            }
            
            print()
            print(responseData)
            do {
            // create json object from data or use JSONDecoder to convert to Model stuct
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    onSuccess(jsonResponse)
                    print(jsonResponse)
                    // handle json response
                    } else {
                        print("data maybe corrupted or in wrong format")
                        onError()
                        throw URLError(.badServerResponse)
                    }
            } catch let error {
                print("Response: " + error.localizedDescription)
                onError()
            }
        }
        // perform the task
        task.resume()
    }
}
