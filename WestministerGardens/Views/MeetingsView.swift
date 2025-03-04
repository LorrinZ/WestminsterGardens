import SwiftUI

struct MeetingsView: View {
    @State private var newMeetingTitle: String = ""
    @State private var newMeetingDescription: String = ""
    @State private var newSelectedDate = Date()
    @State private var newParticipants: String = ""
    @State private var isAddingNewMeeting = false
    @Binding var isAdmin: Bool
    @ObservedObject var meetingViewModel: MeetingViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if meetingViewModel.meetings.isEmpty {
                        Text("There are no upcoming meetings.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(meetingViewModel.meetings) { meeting in
                            VStack(alignment: .leading) {
                                Text(meeting.title)
                                    .font(.headline)
                                Text(formattedDate(meeting.date))
                                    .font(.subheadline)
                                Text("Description: \(meeting.description)")
                                    .font(.subheadline)
                                Text("Participants: \(meeting.participants.joined(separator: ", "))")
                                    .font(.subheadline)
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete(perform: deleteMeeting)  // Enables swipe-to-delete
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Meetings")
            .toolbar {
                if isAdmin {
                    ToolbarItem {
                        Button {
                            isAddingNewMeeting = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddingNewMeeting) {
                NavigationView {
                    Form {
                        Section(header: Text("Meeting Title")) {
                            TextField("Enter meeting title", text: $newMeetingTitle)
                        }
                        Section(header: Text("Meeting Description")) {
                            TextField("Enter meeting description", text: $newMeetingDescription)
                        }
                        Section(header: Text("Meeting Date & Time")) {
                            DatePicker("Select Date & Time", selection: $newSelectedDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                        }
                        Section(header: Text("Participants (comma-separated)")) {
                            TextField("Enter participants", text: $newParticipants)
                        }
                        Section {
                            Button(action: {
                                saveNewMeeting()
                                isAddingNewMeeting = false
                            }) {
                                Text("Save Meeting")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .navigationTitle("Add New Meeting")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isAddingNewMeeting = false
                            }
                        }
                    }
                }
            }
        }
    }

    // Save a new meeting
    func saveNewMeeting() {
        let participantList = newParticipants.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }

        meetingViewModel.addMeeting(
            title: newMeetingTitle,
            date: newSelectedDate,
            description: newMeetingDescription,
            participants: participantList
        )

        newMeetingTitle = ""
        newMeetingDescription = ""
        newSelectedDate = Date()
        newParticipants = ""
    }

    // Delete meeting from list
    func deleteMeeting(at offsets: IndexSet) {
        meetingViewModel.deleteMeeting(at: offsets)
    }

    // Format Date
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
