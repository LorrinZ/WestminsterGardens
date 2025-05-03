
import FirebaseStorage
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil

    func loadImage(from path: String) {
        let storageRef = Storage.storage().reference(withPath: path)

        storageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }

            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
