//
//  MeetingViewModel.swift
//  WestministerGardens
//
//  Created by Maggie Otto on 19/11/2024.
//

import Foundation
import FirebaseFirestore
//import FirebaseFirestoreSwift

class MeetingViewModel: ObservableObject {
    @Published var meetings: [Meeting] = []
    private let db = Firestore.firestore()
    private let collectionName = "meetings"
    
    //    init() {
    //        fetchMeetings()
    //    }
    
    /// Fetch all meetings from Firestore
    //    func fetchMeetings() {
    //        db.collection(collectionName)
    //            .order(by: "date", descending: false)
    //            .addSnapshotListener { [weak self] snapshot, error in
    //                if let error = error {
    //                    print("Error fetching meetings: \(error.localizedDescription)")
    //                    return
    //                }
    //
    //                guard let documents = snapshot?.documents else {
    //                    print("No meetings found")
    //                    return
    //                }
    //
    //                self?.meetings = documents.compactMap { doc -> Meeting? in
    //                    try? doc.data(as: Meeting.self)
    //                }
    //            }
    //    }
    
    /// Add a new meeting to Firestore
    func addMeeting(title: String, date: Date, description: String, participants: [String]) {
        let newMeeting = Meeting(
            id: UUID().uuidString,
            title: title,
            date: date,
            description: description,
            participants: participants
        )
        
        //        do {
        //            try db.collection(collectionName).document(newMeeting.id).setData(from: newMeeting)
        //        } catch {
        //            print("Error adding meeting: \(error.localizedDescription)")
        //        }
        //    }
        
        /// Update an existing meeting in Firestore
        //    func updateMeeting(meeting: Meeting) {
        //        do {
        //            try db.collection(collectionName).document(meeting.id).setData(from: meeting)
        //        } catch {
        //            print("Error updating meeting: \(error.localizedDescription)")
        //        }
        //    }
        
        /// Delete a meeting from Firestore
        //    func deleteMeeting(meeting: Meeting) {
        //        db.collection(collectionName).document(meeting.id).delete { error in
        //            if let error = error {
        //                print("Error deleting meeting: \(error.localizedDescription)")
        //            }
        //        }
        //    }
    }
}
