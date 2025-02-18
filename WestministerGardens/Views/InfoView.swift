//
//  InfoView.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("Contacts").foregroundColor(.black).fontWeight(.bold).padding().font(.title)
                ContactCardView(name:"Connie", role: "Community Manager", phone: "078462934890", email: "connie@westministergardens.org.uk", imageName: "Connie")
                ContactCardView(name:"George", role: "Porter", phone: "07303044050100", email: "george@westminstergardens.org.uk", imageName: "george")
                
            }
            
            // Add Useful Information UI
        }
        .navigationTitle("Info")
//        .background(Image("NightMountains"))
        .background(Color.white.opacity(0.5))
    }
}

//class ViewController: UIViewController {
//    @IBOutlet var imageView: UIImageView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        imageView.image = Image("Connie")
//
//        
//        imageView.backgroundColor = .white
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = imageView.frame.height / 2
//    }
//}

// contact card
struct ContactCardView: View {
    var name: String;
    var role: String;
    var phone: String;
    var email: String;
    var imageName: String;
    
    var body: some View {
        // profile photo
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    // image border effect by overlaying image on top of white circle and then setting border attrs of this circle:
                    Circle().stroke(.white, lineWidth: 7)
                }
                .shadow(radius: 7)
                .padding(10)
   
            
            // Role
            Text(name)
            Text(role)
            Text(phone)
            Text(email)
                .multilineTextAlignment(.center)
            // name
            //...
        }
        .padding(20)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(30)
        .padding(20)
        
    }
    
}

#Preview {
    InfoView()
}
