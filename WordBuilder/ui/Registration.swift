//
//  Registration.swift
//  WordBuilder
//
//  Created by ilya on 6.10.22.
//

import SwiftUI
import RealmSwift

struct Registration: View {
    @State private var name = ""
    @State private var showLevelView = false
    @State private var showLeaderboardView = false
    @State private var showErrorAlert = false
    @State private var isNameShort = false
    @State private var isServerError = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello \(name)")
                TextField("Enter your name", text:$name)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        
                Button(
                    action: {
                        let application = Application()
                        application.name = name
                        
                        if(name.count < 3) {
                            self.showErrorAlert.toggle()
                            self.isNameShort.toggle()
                            return
                        }
                        
                        Network.createPostRequest(endpoint: Endpoints.applications, application: application, parameters: ["name": application.name], onSuccess: { jsonResponse in
                            let json = jsonResponse as! Dictionary<String, String>
                            application.token = json["token"]!
                            let realm = try! Realm()
                            try! realm.write {
                                realm.add(application)
                            }
                            self.showLevelView.toggle()
                        }, onError: {
                            print("some wrong")
                            self.showErrorAlert.toggle()
                            self.isServerError.toggle()
                        })
                }, label: {
                    Text("Register".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Color.purple
                                .cornerRadius(10)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        )
                    })
                    .alert(isPresented: $showErrorAlert) {
                        if isNameShort {
                            return Alert(title: Text("Short name"),
                                         message: Text("Your lenght name should be more than 3"),
                                         dismissButton: .default(Text("OK")))
                        } else {
                            return Alert(title: Text("Server error"),
                                         message: Text("Please, register later or change your name to another one"),
                                         dismissButton: .default(Text("OK")))
                        }
                    }
                
                NavigationLink(
                    destination: LevelScreen().navigationBarHidden(true),
                    isActive: $showLevelView,
                    label: {
                        
                    }
                )
            }
        }
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}
