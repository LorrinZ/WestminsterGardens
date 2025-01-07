//
//  ContentView.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Spacer()
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            MeetingsView(meetingViewModel: MeetingViewModel())
                .tabItem {
                    Label("Meetings", systemImage: "calendar")
                }
            
            DiscussionView()
                .tabItem {
                    Label("Discussions", systemImage: "message.fill")
                }
            
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}
