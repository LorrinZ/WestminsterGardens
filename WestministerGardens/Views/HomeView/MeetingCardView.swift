//
//  MeetingCardView.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import SwiftUI

struct MeetingCard: View {
    var meeting: Meeting

    var body: some View {
        VStack(alignment: .leading) {
            Text(meeting.title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 2)

            Text(meeting.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 2)

            Text(meeting.description)
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

#Preview {
    MeetingCard(meeting: testData.meetings.first!)
}
