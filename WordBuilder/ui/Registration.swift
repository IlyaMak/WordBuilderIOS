//
//  Registration.swift
//  WordBuilder
//
//  Created by ilya on 6.10.22.
//

import SwiftUI

struct Registration: View {
    @State private var name = ""
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("Hello \(name)")
            TextField("Enter your name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    
            Button(action: {
                withAnimation {
                    viewRouter.currentPage = .page2
                }
            }) {
                Text("Register".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Color.purple
                            .cornerRadius(10)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    )
                }
        }
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration().environmentObject(ViewRouter())
    }
}
