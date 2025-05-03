
import SwiftUI
import FirebaseStorage

struct UploadImageView: View {
    @State private var image: UIImage? = nil
    @State private var imageURL: String = ""

    let storage = Storage.storage()

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
            } else {
                Text("Select an Image")
            }

            Button("Upload Image") {
                if let image = image {
                    uploadImage(image: image)
                }
            }
            .padding()

            if !imageURL.isEmpty {
                Text("Image uploaded. URL: \(imageURL)")
            }
        }
        .sheet(isPresented: .constant(false)) {
            // Your Image Picker can go here
            ImagePicker(image: $image)
        }
    }

    func uploadImage(image: UIImage) {
        let storageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }

                storageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                        return
                    }
                    if let url = url {
                        imageURL = url.absoluteString
                        print("Image URL: \(imageURL)")
                    }
                }
            }
        }
    }
}

#Preview {
    UploadImageView()
}
