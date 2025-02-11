import SwiftUI

struct MeetingsView: View {
    @State private var newMeetingTitle: String = ""
    @State private var newMeetingDescription: String = ""
    @State private var newSelectedDate = Date()
    @State private var newParticipants: String = ""
    @State private var isAddingNewMeeting = false  // Controls the sheet presentation
    @EnvironmentObject var adminRights: AdminRights
    
    @ObservedObject var meetingViewModel: MeetingViewModel  // Inject the view model
    
    var body: some View {
        NavigationView {
            VStack {
                // List of Existing Meetings
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
                    }
                }
                .listStyle(PlainListStyle())  // Optional styling for the list
            }
            .navigationTitle("Meetings!")
            .toolbar {
                ToolbarItem {
                    Button {
                        isAddingNewMeeting = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingNewMeeting) {
                NavigationView {
                    Form {
                        // Meeting Title
                        Section(header: Text("Meeting Title")) {
                            TextField("Enter meeting title", text: $newMeetingTitle)
                        }

                        // Meeting Description
                        Section(header: Text("Meeting Description")) {
                            TextField("Enter meeting description", text: $newMeetingDescription)
                        }

                        // Date Picker for Meeting Date and Time
                        Section(header: Text("Meeting Date & Time")) {
                            DatePicker("Select Date & Time", selection: $newSelectedDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                        }

                        // Participants
                        Section(header: Text("Participants (comma-separated)")) {
                            TextField("Enter participants", text: $newParticipants)
                        }

                        // Save Meeting Button
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

    // Function to handle saving the new meeting
    func saveNewMeeting() {
        let participantList = newParticipants.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }

        // Add the new meeting to the view model
        meetingViewModel.addMeeting(
            title: newMeetingTitle,
            date: newSelectedDate,
            description: newMeetingDescription,
            participants: participantList
        )

        // Clear fields after saving
        newMeetingTitle = ""
        newMeetingDescription = ""
        newSelectedDate = Date()
        newParticipants = ""
    }

    // Helper function to format the date
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
