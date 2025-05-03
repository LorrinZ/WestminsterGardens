
import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var isAdmin = false
    @State var meetingViewModel = MeetingViewModel()
    @State var discussionViewModel = DiscussionViewModel()

    var body: some View {
        Spacer()
        if isLoggedIn {
            TabView {
                HomeView(isLoggedIn: $isLoggedIn, meetingViewModel: meetingViewModel, discussionViewModel: discussionViewModel)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                MeetingsView(isAdmin: $isAdmin, meetingViewModel: meetingViewModel)
                    .tabItem {
                        Label("Meetings", systemImage: "calendar")
                    }
                
                DiscussionView(discussionViewModel: discussionViewModel)
                    .tabItem {
                        Label("Discussions", systemImage: "message.fill")
                    }
                
                InfoView()
                    .tabItem {
                        Label("Info", systemImage: "info.circle.fill")
                    }
                
//                SettingsView()
//                    .tabItem {
//                        Label("Settings", systemImage: "gearshape.fill")
//                    }
            }
        } else {
            LoginScreenView(isLoggedIn: $isLoggedIn, isAdmin: $isAdmin)
        }
    }
}
