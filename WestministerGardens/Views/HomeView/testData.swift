//
//  testData.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import Foundation

struct testData {
    // Placeholder data for meetings
    static var meetings: [Meeting] = [
        Meeting(id: "1", title: "Monthly Board Meeting", date: Date().addingTimeInterval(86400 * 5), description: "Discuss community issues and upcoming projects.", participants: ["John", "Sarah", "Mike"]),
        Meeting(id: "2", title: "Budget Planning Meeting", date: Date().addingTimeInterval(86400 * 10), description: "Review budget proposals for next year.", participants: ["Anna", "Jake"]),
        Meeting(id: "3", title: "Community Clean-up", date: Date().addingTimeInterval(86400 * 15), description: "Join us for a community clean-up day!", participants: ["Lisa", "Tom"]),
    ]
    
    // Placeholder data for discussions
    static var discussions: [Discussion] = [
        Discussion(id: "1", title: "New Pool Hours", content: "Should we extend the pool hours during summer?", dateCreated: Date(), author: "John", comments: []),
        Discussion(id: "2", title: "Community Garden Ideas", content: "What flowers and vegetables should we plant in the community garden?", dateCreated: Date(), author: "Sarah", comments: []),
        Discussion(id: "3", title: "Parking Concerns", content: "Several residents have expressed concerns about parking spaces.", dateCreated: Date(), author: "Mike", comments: []),
    ]
    
    // Placeholder data for notices
    static var notices: [Notice] = [
        Notice(id: "1", title: "Pool Maintenance", content: "The pool will be closed for maintenance on Saturday.", dateCreated: Date()),
        Notice(id: "2", title: "Fire Drill", content: "There will be a fire drill on Tuesday at 10 AM.", dateCreated: Date()),
        Notice(id: "3", title: "Community BBQ", content: "Join us for a community BBQ next Friday!", dateCreated: Date()),
    ]

}
