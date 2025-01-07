import SwiftUI

struct MeetingsView: View {
    @State private var meetingTitle: String = ""
    @State private var meetingDescription: String = ""
    @State private var selectedDate = Date()  // Holds the selected date and time
    @State private var participants: String = ""  // Comma-separated list of participants
    
    @ObservedObject var meetingViewModel: MeetingViewModel  // Inject the view model
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // Meeting Title
                    Section(header: Text("Meeting Title")) {
                        TextField("Enter meeting title", text: $meetingTitle)
                    }

                    // Meeting Description
                    Section(header: Text("Meeting Description")) {
                        TextField("Enter meeting description", text: $meetingDescription)
                    }

                    // Date Picker for Meeting Date and Time
                    Section(header: Text("Meeting Date & Time")) {
                        DatePicker("Select Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                    }

                    // Participants
                    Section(header: Text("Participants (comma-separated)")) {
                        TextField("Enter participants", text: $participants)
                    }

                    // Save Meeting Button
                    Section {
                        Button(action: {
                            saveMeeting()  // Call save function
                        }) {
                            Text("Save Meeting")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    // List of Existing Meetings
                    List {
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
                    .listStyle(PlainListStyle())  // Optional styling for the list
                    .frame(minHeight: 400)
                }
                .navigationTitle("Schedule Meeting")
                }
                
                
        }
    }

    // Function to handle saving the meeting
    func saveMeeting() {
        let participantList = participants.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }

        meetingViewModel.addMeeting(
            title: meetingTitle,
            date: selectedDate,
            description: meetingDescription,
            participants: participantList
        )

        // Clear fields after saving
        meetingTitle = ""
        meetingDescription = ""
        selectedDate = Date()
        participants = ""
    }

    // Helper function to format the date
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
