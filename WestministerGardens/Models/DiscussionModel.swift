//
//  DiscussionModel.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import Foundation

struct Discussion: Identifiable {
    var id: String  // Unique identifier for Firestore
    var title: String
    var content: String
    var dateCreated: Date
    var author: String  // Author's name or ID
    var comments: [Comment]  // List of comments associated with this discussion
}

struct Comment: Identifiable {
    var id: String  // Unique identifier for each comment
    var content: String
    var author: String  // Author's name or ID
    var dateCreated: Date
}
