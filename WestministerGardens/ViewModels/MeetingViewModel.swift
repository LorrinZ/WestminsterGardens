import Foundation
import Combine

class MeetingViewModel: ObservableObject {
    @Published var meetings: [Meeting] = testData.meetings

    // Add a new meeting
    func addMeeting(title: String, date: Date, description: String, participants: [String]) {
        let newMeeting = Meeting(
            id: UUID().uuidString,
            title: title,
            date: date,
            description: description,
            participants: participants
        )
        meetings.append(newMeeting)
    }

    // Delete meeting
    func deleteMeeting(at offsets: IndexSet) {
        meetings.remove(atOffsets: offsets)
    }
}
