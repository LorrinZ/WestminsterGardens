import SwiftUI

struct DiscussionView: View {
    @ObservedObject var discussionViewModel: DiscussionViewModel
    @State private var newDiscussionTitle: String = ""
    @State private var newDiscussionContent: String = ""
    @State private var newCommentContent: [String: String] = [:]
    @State private var isNewPostExpanded: Bool = false
    @State private var commentVisibility: [String: Bool] = [:]

    var body: some View {
        NavigationView {
            VStack {
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

                List {
                    ForEach(discussionViewModel.discussions) { discussion in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(discussion.title)
                                .font(.headline)
                            Text(discussion.content)
                                .font(.subheadline)

                            Button(action: {
                                toggleComments(for: discussion)
                            }) {
                                HStack {
                                    Text(commentVisibility[discussion.id] == true ? "Hide Comments" : "Show Comments")
                                    Text("(\(discussion.comments.count))")
                                    Spacer()
                                    Image(systemName: commentVisibility[discussion.id] == true ? "chevron.up" : "chevron.down")
                                }
                                .foregroundColor(.blue)
                            }
                            
                            if commentVisibility[discussion.id] == true {
                                VStack(alignment: .leading, spacing: 5) {
                                    ForEach(discussion.comments) { comment in
                                        Text("• \(comment.content)")
                                            .font(.footnote)
                                            .padding(.leading)
                                    }

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
                    .onDelete(perform: deleteDiscussion) // Swipe to delete feature
                }
            }
            .navigationTitle("Discussions")
        }
    }

    private func addDiscussion() {
        guard !newDiscussionTitle.isEmpty && !newDiscussionContent.isEmpty else { return }
        let newDiscussion = discussionViewModel.addDiscussion(title: newDiscussionTitle, content: newDiscussionContent, dateCreated: Date(), author: "Admin")
        commentVisibility[newDiscussion.id] = false
        newCommentContent[newDiscussion.id] = ""
        newDiscussionTitle = ""
        newDiscussionContent = ""
        isNewPostExpanded = false
    }

    private func addComment(to discussion: Discussion) {
        guard let commentContent = newCommentContent[discussion.id], !commentContent.isEmpty else { return }
        
        if let index = discussionViewModel.discussions.firstIndex(where: { $0.id == discussion.id }) {
            let _ = discussionViewModel.addComment(to: discussion, content: commentContent, dateCreated: Date(), author: "User")
            newCommentContent[discussion.id] = ""
            commentVisibility[discussion.id] = true
        }
    }

    private func toggleComments(for discussion: Discussion) {
        if let isVisible = commentVisibility[discussion.id] {
            commentVisibility[discussion.id] = !isVisible
        } else {
            commentVisibility[discussion.id] = true
        }
    }

    private func deleteDiscussion(at offsets: IndexSet) {
        discussionViewModel.deleteDiscussion(at: offsets)
    }
}
