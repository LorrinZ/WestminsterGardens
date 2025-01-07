import SwiftUI

struct DiscussionView: View {
    @State private var discussions: [Discussion] = testData.discussions
    @State private var newDiscussionTitle: String = ""
    @State private var newDiscussionContent: String = ""
    @State private var newCommentContent: [String: String] = [:]  // Dictionary to hold comment content per discussion
    @State private var isNewPostExpanded: Bool = false  // Toggle for new post section
    @State private var commentVisibility: [String: Bool] = [:]  // Track visibility per discussion

    var body: some View {
        NavigationView {
            VStack {
                // Collapsible button to show/hide new post section
                Button(action: {
                    isNewPostExpanded.toggle()
                }) {
                    HStack {
                        Text(isNewPostExpanded ? "Hide New Post" : "Add New Post")
                        Spacer()
                        Image(systemName: isNewPostExpanded ? "chevron.up" : "chevron.down")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
                .padding()

                // New post section that shows when isNewPostExpanded is true
                if isNewPostExpanded {
                    VStack {
                        TextField("Discussion Title", text: $newDiscussionTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding([.horizontal, .top])
                        TextEditor(text: $newDiscussionContent)
                            .frame(height: 100)
                            .border(Color.gray, width: 1)
                            .padding([.horizontal, .bottom])
                        
                        Button(action: addDiscussion) {
                            Text("Post Discussion")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding([.horizontal, .bottom])
                    }
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding()
                }

                // List of discussions with expandable comments section
                List(discussions) { discussion in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(discussion.title)
                            .font(.headline)
                        Text(discussion.content)
                            .font(.subheadline)

                        // Toggle button for showing/hiding comments, with comment count in brackets
                        Button(action: {
                            toggleComments(for: discussion)
                        }) {
                            HStack {
                                Text(commentVisibility[discussion.id] == true ? "Hide Comments" : "Show Comments")
                                Text("(\(discussion.comments.count))")  // Comment count in brackets
                                Spacer()
                                Image(systemName: commentVisibility[discussion.id] == true ? "chevron.up" : "chevron.down")
                            }
                            .foregroundColor(.blue)
                        }
                        
                        // Comments section (visible only if expanded)
                        if commentVisibility[discussion.id] == true {
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(discussion.comments) { comment in
                                    Text("• \(comment.content)")
                                        .font(.footnote)
                                        .padding(.leading)
                                }

                                // Add comment field with button
                                TextField("Add a comment...", text: Binding(
                                    get: { newCommentContent[discussion.id, default: ""] },
                                    set: { newCommentContent[discussion.id] = $0 }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding([.horizontal, .top])
                                
                                Button(action: {
                                    addComment(to: discussion)
                                }) {
                                    Text("Comment")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .padding([.horizontal, .bottom])
                            }
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding()
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Discussions")
        }
    }

    private func addDiscussion() {
        guard !newDiscussionTitle.isEmpty && !newDiscussionContent.isEmpty else { return }
        
        let newDiscussion = Discussion(id: UUID().uuidString, title: newDiscussionTitle, content: newDiscussionContent, dateCreated: Date(), author: "Admin", comments: [])
        discussions.append(newDiscussion)
        commentVisibility[newDiscussion.id] = false  // Initialize visibility for the new discussion
        newCommentContent[newDiscussion.id] = ""  // Initialize new comment content for the new discussion
        newDiscussionTitle = ""
        newDiscussionContent = ""
        isNewPostExpanded = false  // Collapse the new post section after adding
    }

    private func addComment(to discussion: Discussion) {
        guard let commentContent = newCommentContent[discussion.id], !commentContent.isEmpty else { return }  // Ensure comment isn't empty
        
        if let index = discussions.firstIndex(where: { $0.id == discussion.id }) {
            let newComment = Comment(id: UUID().uuidString, content: commentContent, author: "User", dateCreated: Date())
            discussions[index].comments.append(newComment)
            newCommentContent[discussion.id] = ""  // Clear the comment input after posting
            
            // Ensure the comment section remains visible by keeping visibility state intact
            commentVisibility[discussion.id] = true
        }
    }

    private func toggleComments(for discussion: Discussion) {
        // Toggle the visibility of comments for the selected discussion
        if let isVisible = commentVisibility[discussion.id] {
            commentVisibility[discussion.id] = !isVisible
        } else {
            commentVisibility[discussion.id] = true  // Default to showing if not tracked
        }
    }
}

struct DiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        DiscussionView()
    }
}
