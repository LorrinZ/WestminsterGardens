//
//  MeetingModel.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import Foundation

struct Meeting: Identifiable {
    var id: String  // Unique identifier for Firestore
    var title: String
    var date: Date
    var description: String
    var participants: [String]  // List of participant names or IDs
}
