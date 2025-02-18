//
//  HomeView.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

// NOTES
// Firestore logic to fetch upcoming meetings
// Example:
// FirestoreService().loadMeetings { meetings in
//     self.upcomingMeetings = meetings
// }

import SwiftUI

struct HomeView: View {
    @Binding var isLoggedIn: Bool
    @State private var upcomingMeetings: [Meeting] = []
    @State private var recentDiscussions: [Discussion] = []
    @State private var notices: [Notice] = []
    @ObservedObject var meetingViewModel: MeetingViewModel
    @ObservedObject var discussionViewModel: DiscussionViewModel

    var body: some View {
        ZStack {
            ColourPalette.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            NavigationStack {
                ScrollView {

                    VStack(alignment: .leading) {
                        Text("Welcome to Westminster Gardens")
                            .font(FontConfig.titleFont)
                            .fontWeight(.bold)
                            .foregroundColor(ColourPalette.textColor)
                            .padding()
                        
                        //TODO: add "view all" navigation link
                        // Upcoming Meetings Section
                        Section(header: Text("Upcoming Meetings")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.bottom, 5)) {
                                if meetingViewModel.meetings.isEmpty {
                                    Text("No upcoming meetings.")
                                        .foregroundColor(.gray)
                                } else {
                                    MeetingRowView(meetings: Array(meetingViewModel.meetings.prefix(5)))
                                }
                            }
                            .padding(.horizontal)
                        
                        Spacer().frame(height: 30)
                        
                        // Recent Discussions Section
                        Section(header: Text("Recent Discussions")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.bottom, 5)) {
                                if discussionViewModel.discussions.isEmpty {
                                    Text("No recent discussions.")
                                        .foregroundColor(.gray)
                                } else {
                                    ForEach(discussionViewModel.discussions.prefix(3)) { discussion in
                                        DiscussionCard(discussion: discussion)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        
                        Spacer().frame(height: 30)
                        
                        // Notices Section
                        Section(header: Text("Notices")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.bottom, 5)) {
                                if notices.isEmpty {
                                    Text("No recent notices.")
                                        .foregroundColor(.gray)
                                } else {
                                    ForEach(notices.prefix(3)) { notice in
                                        NoticeCard(notice: notice)
                                    }
                                }
                            }
                            .padding(.horizontal)
                    }
                    .padding()
//                    .cornerRadius(12)
//                    .shadow(radius: 5)
//                    .padding()
                    Button(action: {
                        isLoggedIn = false
                    }) {
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .onAppear {
                    loadDashboardData()  // Load data when view appears
                }
            }
        }
    }

    private func loadDashboardData() {
        loadUpcomingMeetings()
        loadRecentDiscussions()
        loadNotices()
    }

    private func loadUpcomingMeetings() {
        // Firestore logic to fetch upcoming meetings
        // Example:
        // FirestoreService().loadMeetings { meetings in
        //     self.upcomingMeetings = meetings
        // }
        
        // Placeholder data for upcoming meetings
        upcomingMeetings = testData.meetings
    }

    private func loadRecentDiscussions() {
        // Firestore logic to fetch recent discussions
        
        // Placeholder data for recent discussions
        recentDiscussions = testData.discussions
    }

    private func loadNotices() {
        // Firestore logic to fetch recent notices
        notices = testData.notices
    }
}

struct DiscussionCard: View {
    var discussion: Discussion

    var body: some View {
        VStack(alignment: .leading) {
            Text(discussion.title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 2)

            Text(discussion.content)
                .font(.body)
                .lineLimit(2) // Limit to 2 lines
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Shadow effect
    }
}

struct NoticeCard: View {
    var notice: Notice

    var body: some View {
        VStack(alignment: .leading) {
            Text(notice.title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 2)

            Text(notice.content)
                .font(.body)
                .lineLimit(2) // Limit to 2 lines
                .foregroundColor(.black)

            Text(notice.dateCreated, style: .date)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Shadow effect
    }
}

