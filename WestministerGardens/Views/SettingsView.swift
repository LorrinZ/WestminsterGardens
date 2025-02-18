//
//  SettingsView.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import SwiftUI

struct SettingsView: View {
//    @EnvironmentObject var themeViewModel: ThemeViewModel // Access the theme view model
    @EnvironmentObject var adminRights: AdminRights

    var body: some View {
        VStack {
            //TODO: need to update all other pages & icons to rely on colourpalette for dark mode to take full effect
//            Form {
//                Section(header: Text("Appearance")) {
//                    Toggle("Dark Mode", isOn: $themeViewModel.isDarkMode)
//                        .toggleStyle(SwitchToggleStyle(tint: Color.blue)) // Customize the toggle style
//                }
//            }
//            .navigationTitle("Settings")
//            .background(ColourPalette.contentBackgroundColor(isDarkMode: themeViewModel.isDarkMode)) // Background for the Form
//            .scrollContentBackground(.hidden) // Hide default background
            
            //Placeholder
            Spacer()
            Text("Settings")
//            
//            Spacer()
//            LoginScreenView()
//            if adminRights.isAdmin {
//                LoginScreenView()
//            } else {
//                Text("Successfully logged in.").foregroundColor(<#T##color: Color?##Color?#>)
//            }
            
            Spacer()
        }
//        .background(ColourPalette.contentBackgroundColor(isDarkMode: themeViewModel.isDarkMode)) // Ensure background covers entire view
        .edgesIgnoringSafeArea(.all) // Ignore safe area for complete background coverage
//        .preferredColorScheme(themeViewModel.isDarkMode ? .dark : .light) // Apply the color scheme based on the toggle
    }
}

