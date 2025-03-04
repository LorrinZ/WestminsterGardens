import Foundation
import Combine

class DiscussionViewModel: ObservableObject {
    @Published var discussions: [Discussion] = testData.discussions

    func addDiscussion(title: String, content: String, dateCreated: Date, author: String) -> Discussion {
        let newDiscussion = Discussion(
            id: UUID().uuidString,
            title: title,
            content: content,
            dateCreated: dateCreated,
            author: author,
            comments: []
        )
        discussions.append(newDiscussion)
        return newDiscussion
    }
    
    func addComment(to discussion: Discussion, content: String, dateCreated: Date, author: String) -> Comment {
        let newComment = Comment(id: UUID().uuidString, content: content, author: author, dateCreated: dateCreated)
        if let index = discussions.firstIndex(where: { $0.id == discussion.id }) {
            discussions[index].comments.append(newComment)
        }
        return newComment
    }

    func deleteDiscussion(at offsets: IndexSet) {
        discussions.remove(atOffsets: offsets)
    }
}
