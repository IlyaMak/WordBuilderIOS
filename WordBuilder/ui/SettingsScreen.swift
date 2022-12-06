//
//  SettingsScreen.swift
//  WordBuilder
//
//  Created by ilya on 6.12.22.
//

import SwiftUI

struct SettingsScreen: View {
    @State var colorThemes = ["light", "dark"]
    @State var selectedItem = "light"
    
    var body: some View {
        VStack {
            Picker("Themes", selection: $selectedItem) {
                ForEach(colorThemes, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}
