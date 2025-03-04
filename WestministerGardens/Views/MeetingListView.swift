import SwiftUI

struct MeetingListView: View {
    @ObservedObject var meetingViewModel: MeetingViewModel
    
    var body: some View {
        List {
            if meetingViewModel.meetings.isEmpty {
                Text("No Meetings Scheduled")
                    .foregroundColor(.gray)
            } else {
                ForEach(meetingViewModel.meetings) { meeting in
                    NavigationLink(destination: MeetingDetailView(meeting: meeting)) {
                        VStack(alignment: .leading) {
                            Text(meeting.title)
                                .font(.headline)
                            Text(formattedDate(meeting.date))
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteMeeting) // Swipe-to-delete enabled
            }
        }
        .navigationTitle("Meeting List")
    }

    func deleteMeeting(at offsets: IndexSet) {
        meetingViewModel.deleteMeeting(at: offsets)
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct MeetingDetailView: View {
    var meeting: Meeting

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(meeting.title)
                .font(.largeTitle)
                .bold()
            Text("Date: \(formattedDate(meeting.date))")
                .font(.subheadline)
            Text("Description: \(meeting.description)")
                .font(.body)
            Text("Participants: \(meeting.participants.joined(separator: ", "))")
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Meeting Details")
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
