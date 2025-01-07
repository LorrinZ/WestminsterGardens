//
//  FirestoreService.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import FirebaseFirestore

class FirestoreService {
    private let db = Firestore.firestore()
    
    @Published var meetings: [Meeting] = []
    
    func loadMeetings() {
        db.collection("meetings").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching meetings: \(error)")
                return
            }
            
            self.meetings = snapshot?.documents.compactMap { document in
                let data = document.data()
                return Meeting(
                    id: document.documentID,
                    title: data["title"] as? String ?? "",
                    date: (data["date"] as? Timestamp)?.dateValue() ?? Date(),
                    description: data["description"] as? String ?? "",
                    participants: data["participants"] as? [String] ?? []
                )
            } ?? []
        }
    }
    
    func testFirestore() {
        let testDocument = ["testField": "This is a test value"]
        db.collection("testCollection").addDocument(data: testDocument) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully!")
            }
        }
    }
    
    func testCreateUsers() {
        let testData: [String: Any] = [
            "name": "Test User",
            "email": "test@example.com",
            "notificationsEnabled": true,
            "profilePictureUrl": "https://example.com/profile.jpg"
        ]

        // Adding a document to the "users" collection
        db.collection("users").addDocument(data: testData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added successfully!")
            }
        }
    }
    
    func fetchUserProfiles(completion: @escaping ([UserProfile]) -> Void) {
            db.collection("users").getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    completion([]) // Return empty array on error
                } else {
                    var userProfiles: [UserProfile] = []
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if let name = data["name"] as? String,
                           let email = data["email"] as? String,
                           let notificationsEnabled = data["notificationsEnabled"] as? Bool,
                           let profilePictureUrl = data["profilePictureUrl"] as? String? {
                            let userProfile = UserProfile(
                                id: document.documentID, // Use Firestore document ID
                                name: name,
                                email: email,
                                notificationsEnabled: notificationsEnabled,
                                profilePictureUrl: profilePictureUrl
                            )
                            userProfiles.append(userProfile)
                        }
                    }
                    completion(userProfiles) // Return the array of UserProfiles
                }
            }
        }
}

