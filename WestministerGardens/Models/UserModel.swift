//
//  UserModel.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import Foundation

struct UserProfile: Identifiable {
    var id: String  // Unique identifier for the user
    var name: String
    var email: String
    var notificationsEnabled: Bool  // Preference for notifications
    var profilePictureUrl: String?  // Optional URL for profile picture
}
