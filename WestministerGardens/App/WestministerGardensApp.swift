//
//  WestministerGardensApp.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import SwiftUI
import FirebaseCore

// setup for Firebase app delegate - when using push notification/background tasks
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//    return true
//  }
//
//    // Optional: Handle push notifications, background tasks, etc.
//    func application(_ application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        // Handle device token for push notifications (if using Firebase Cloud Messaging)
//    }
//}

@main
struct WestministerGardensApp: App {
    
    // register app delegate (root object of app) for Firebase setup
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // simple init for Auth & Firestore only
    init() {
            FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.colorScheme, .light) // .light or .dark
                .environmentObject(AdminRights())
            
//                .onAppear() {
//                    testFirebase()
//                }
        }
    }
    
    // Call onAppear for ContentView to test if firebase add doc is working
    func testFirebase() {
        let firestoreService = FirestoreService()
        firestoreService.testFirestore()  // Call the test function
        // create and fetch users
        firestoreService.testCreateUsers()
        firestoreService.fetchUserProfiles { fetchedUserProfiles in
            // Print the names of the fetched user profiles to the console
            for userProfile in fetchedUserProfiles {
                print("User Name: \(userProfile.name)")
            }
        }
    }
}
