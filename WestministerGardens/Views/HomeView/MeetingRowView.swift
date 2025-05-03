

import SwiftUI

struct MeetingRowView: View {
    var meetings: [Meeting]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(meetings) { meeting in
                    MeetingCard(meeting: meeting)
                        .frame(maxWidth:300)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
//        .padding(.vertical)
    }
}

#Preview {
    MeetingRowView(meetings: testData.meetings)
}
