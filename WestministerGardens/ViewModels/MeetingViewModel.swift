import Foundation
import Combine

class MeetingViewModel: ObservableObject {
    @Published var meetings: [Meeting] = []

    // Function to add a new meeting
    func addMeeting(title: String, date: Date, description: String, participants: [String]) {
        let newMeeting = Meeting(
            id: UUID().uuidString,  // Generate a unique ID
            title: title,
            date: date,
            description: description,
            participants: participants
        )
        meetings.append(newMeeting)
    }
}
