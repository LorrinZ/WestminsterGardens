//
//  NoticeModel.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import Foundation

struct Notice: Identifiable {
    var id: String  // Unique identifier for Firestore
    var title: String
    var content: String
    var dateCreated: Date
}
